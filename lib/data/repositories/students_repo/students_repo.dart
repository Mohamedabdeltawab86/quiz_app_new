import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:quiz_app_new/data/models/user_profile.dart';
import 'package:quiz_app_new/utils/common_functions.dart';
import 'package:quiz_app_new/utils/constants.dart';

import '../../models/course.dart';

class StudentsRepo {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

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

  Future<bool> enrollCourse(String courseId) async {
    final Course? course = (await _coursesRef.doc(courseId).get()).data();
    final UserProfile? currentUser = await getCurrentUser();
    if (course != null && currentUser != null) {
      await _usersRef
          .doc(getUid())
          .set(
            currentUser.copyWith(
              subscribedCourses: ([...currentUser.subscribedCourses, courseId])
                  .toSet()
                  .toList(),
            ),
            SetOptions(merge: true),
          );
      print("HELLO!!");
      return true;
    } else {
      return false;
    }
  }
}
