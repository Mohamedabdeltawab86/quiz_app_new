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
    on<SubscribeToCode>(_subscribeToCode);
    on<EnrollCourse>(_enrollCourse);
    on<ChangeIsPathValue>(_changeIsPathValue);
    on<FetchEnrolledCourses>(_fetchEnrolledCourses);
  }

  List<Course> courses = [];

  final codeController = TextEditingController();

  bool isPath = false;

  // 93TnW4T1AMbsKrxvhM4WcsqEFCA2
  Future<void> _changeIsPathValue(
      ChangeIsPathValue event, Emitter<EnrolledState> emit) async {
    isPath = !isPath;
    emit(IsPathValueChanged());
  }

  Future<void> _subscribeToCode(
      SubscribeToCode event, Emitter<EnrolledState> emit) async {
    emit(SubscribeToCodeLoading());
    try {
      if (!isPath) {
        add(EnrollCourse(event.code));
      } else {
        // TODO: 4. enroll in path {list of courses}
      }
      emit(SubscribeToCodeSuccess());
      codeController.clear();
    } catch (e) {
      emit(SubscribeToCodeError(e.toString()));
    }
  }

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
        add(FetchEnrolledCourses());
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
        courses.clear();
        for (String courseId in currentUser.subscribedCourses) {
          var courseDoc = await _coursesRef.doc(courseId).get();
          if (courseDoc.exists) {
            courses.add(courseDoc.data()!);
          }
        }

        courses
            .where(
                (course) => !currentUser.subscribedCourses.contains(course.id))
            .map((course) => course);

        emit(EnrolledCourseFetched());
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
    codeController.dispose();
    return super.close();
  }
}
