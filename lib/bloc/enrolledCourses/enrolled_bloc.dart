import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../data/models/course.dart';
import '../../data/models/user_profile.dart';
import '../../utils/common_functions.dart';
import '../../utils/constants.dart';

part 'enrolled_event.dart';

part 'enrolled_state.dart';

class EnrolledBloc extends Bloc<EnrolledEvent, EnrolledState> {
  EnrolledBloc() : super(EnrolledInitial()) {
    on<SubscribeToTeacher>(_subscribeToTeacher);
    on<EnrollCourse>(_enrollCourse);
    on<FetchEnrolledCourses>(_fetchEnrolledCourses);
  }

  List<Course> myCourses = [];
  final teacherCodeController = TextEditingController();

  Future<void> _subscribeToTeacher(
      SubscribeToTeacher event, Emitter<EnrolledState> emit) async {
    emit(SubscribeToTeacherFetching());
    try {
      final QuerySnapshot teacherSnapshot = await FirebaseFirestore.instance
          .collection(coursesCollection)
          .where("createdBy", isEqualTo: event.teacherId)
          .get();

      // print("teacherSnapshot ${teacherSnapshot.docs.first.data()}");
      if (teacherSnapshot.docs.isEmpty) {
        emit(SubscribeToTeacherError(
            "Invalid Teacher ID or no courses available"));
        return;
      }

      List<Course> teacherCourses = teacherSnapshot.docs
          .map((doc) => Course.fromJson(doc.data() as Map<String, dynamic>))
          .toList();

      final UserProfile? currentUser = await getCurrentUser();

      if (currentUser != null) {
        bool alreadySubscribedInAllCourses = teacherCourses.every(
            (course) => currentUser.subscribedCourses.contains(course.id));

        if (alreadySubscribedInAllCourses) {
          emit(SubscribeToTeacherAlreadySubscribed());
        } else {
          List<String> teacherCoursesIds =
              teacherCourses.map((course) => course.id!).toList();

          List<String> subscribedCourses =
              currentUser.subscribedCourses.toList();
          for (String courseId in teacherCoursesIds) {
            if (!subscribedCourses.contains(courseId)) {
              subscribedCourses.add(courseId);
            }
          }
          await _usersRef.doc(currentUser.userId).update({
            'subscribedCourses': subscribedCourses.toSet().toList(),
          });
          emit(SubscribeToTeacherSuccess());
          add(FetchEnrolledCourses());
        }
      } else {
        emit(SubscribeToTeacherError(
            "Failed to fetch user profile: No teacher with this code"));
      }
    } catch (e) {
      emit(EnrolledCourseFetchingError(e.toString()));
    }
  }

  // 93TnW4T1AMbsKrxvhM4WcsqEFCA2
  Future<void> _enrollCourse(
      EnrollCourse event, Emitter<EnrolledState> emit) async {
    final Course? course = (await _coursesRef.doc(event.courseId).get()).data();
    final UserProfile? currentUser = await getCurrentUser();
    // DONE: 1. check if the course id exists or not first.
    if (course != null && currentUser != null) {
      if (!currentUser.subscribedCourses.contains(event.courseId)) {
        final updatedCourses = [
          ...currentUser.subscribedCourses,
          event.courseId
        ];
        await _usersRef.doc(getUid()).set(
              currentUser.copyWith(
                subscribedCourses: (updatedCourses).toSet().toList(),
              ),
              SetOptions(merge: true),
            );
        emit(EnrolledCourseSuccess());
      } else {
        emit(EnrolledCourseError("Course Not found, please check the code"));
      }
    }
  }

  Future<void> _fetchEnrolledCourses(
      FetchEnrolledCourses event, Emitter<EnrolledState> emit) async {
    emit(EnrolledCourseFetching());
    try {
      final UserProfile? currentUser = await getCurrentUser();
      // final Course? course = (await _coursesRef.doc(currentUser?.userId).get()).data();
      if (currentUser != null) {
        List<Course> courses = [];
        for (String courseId in currentUser.subscribedCourses) {
          var courseDoc = await _coursesRef.doc(courseId).get();
          if (courseDoc.exists) {
            courses.add(courseDoc.data()!.copyWith(isEnrolled: true));
          }
        }
        final QuerySnapshot teacherSnapshot = await FirebaseFirestore.instance
            .collection(coursesCollection)
            .where("createdBy", isEqualTo: currentUser.userId)
            .get();

        print("teacherSnapshot ${teacherSnapshot.docs.first.data()}");

        List<Course> teacherCourses = teacherSnapshot.docs
            .map((doc) => Course.fromJson(doc.data() as Map<String, dynamic>))
            .toList();

        courses
            .where(
                (course) => !currentUser.subscribedCourses.contains(course.id))
            .map((course) => course.copyWith(isEnrolled: false));

        myCourses = courses;
        emit(EnrolledCourseFetched(myCourses));
      }
    } catch (e) {
      emit(EnrolledCourseFetchingError(e.toString()));
    }
  }

  final _coursesRef = FirebaseFirestore.instance
      .collection(coursesCollection)
      .withConverter<Course>(
        fromFirestore: (snapshot, options) => Course.fromJson(snapshot.data()!),
        toFirestore: (course, options) => course.toJson(),
      );

  final _usersRef = FirebaseFirestore.instance
      .collection(usersCollection)
      .withConverter<UserProfile>(
        fromFirestore: (snapshot, options) =>
            UserProfile.fromJson(snapshot.data()!),
        toFirestore: (user, options) => user.toJson(),
      );

  // Future<bool> enrollTeacherCourses() async {
  //   final Course? course =
  //       (await _coursesRef.doc(teacherCodeController.text).get()).data();
  //   final UserProfile? currentUser = await getCurrentUser();
  //   // TODO: 1. check if the course id exists or not first.
  //   if (course != null && currentUser != null) {
  //     await _usersRef.doc(getUid()).set(
  //           currentUser.copyWith(
  //             subscribedCourses: ([
  //               ...currentUser.subscribedCourses,
  //               teacherCodeController.text
  //             ]).toSet().toList(),
  //           ),
  //           SetOptions(merge: true),
  //         );
  //     return true;
  //   } else {
  //     return false;
  //   }
  // }

  @override
  Future<void> close() {
    teacherCodeController.dispose();
    return super.close();
  }
}
