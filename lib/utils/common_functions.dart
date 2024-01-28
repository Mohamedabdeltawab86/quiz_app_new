import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:quiz_app_new/data/models/user_profile.dart';

import '../data/models/course.dart';
import 'constants.dart';

String? isValidEmail(String? email, String message) {
  final regex = RegExp(
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");
  // TODO I want to add different validation messages
  // 1. for empty fields =>> field could not be empty
  // 2. not matching email regex
  // 3. FirebaseAuth Exception
  // if(email == null || email.isEmpty){}

  if (email != null && regex.hasMatch(email)) {
    return null;
  } else {
    return message;
  }
}

String? isValidPassword(String? password, String message) {
  if (password != null && password.length >= 8) {
    return null;
  } else {
    return message;
  }
}

String? isSamePassword({
  required String pass,
  required String passConfirm,
  required String emptyMessage,
  required String mismatchMessage,
}) {
  if (pass.isEmpty && passConfirm.isEmpty) {
    return emptyMessage;
  } else if (pass != passConfirm) {
    return mismatchMessage;
  }
  return null;
}

Future<void> saveUserInDB(UserProfile profile) async {
  await FirebaseFirestore.instance
      .collection(usersCollection)
      .doc(profile.userId ?? getUid())
      .set(profile.toJson(), SetOptions(merge: true))
      .then((value) => print(profile.toJson()));
}

Future<UserProfile> readUserFromDB() async {
  DocumentSnapshot userData = await FirebaseFirestore.instance
      .collection(usersCollection)
      .doc(getUid())
      .get();
  return UserProfile.fromJson(userData.data()! as Map<String, dynamic>);
}

Future<List<Course>> readCoursesFromDB() async {
  QuerySnapshot snapshot = await FirebaseFirestore.instance
      .collection(coursesCollection)
      .where("createdBy", isEqualTo: getUid())
      .get();

  List<Course> courseData = snapshot.docs
      .map((doc) => Course.fromJson(doc.data() as Map<String, dynamic>))
      .toList();

  return courseData;
}

Future<void> saveCourseInDB(Course course) async {
  final courses = FirebaseFirestore.instance
      .collection(coursesCollection)
      .withConverter<Course>(
        fromFirestore: (snapshot, options) => Course.fromJson(snapshot.data()!),
        toFirestore: (course, options) => course.toJson(),
      );

  await courses.add(course);
}

DateTime dateTimeFromTimestamp(Timestamp timestamp) => timestamp.toDate();

Timestamp? dateTimeToTimestamp(DateTime? dateTime) {
  if (dateTime != null) {
    return Timestamp.fromDate(dateTime);
  } else {
    return null;
  }
}

Future<bool> doesUserHasInfo(String uid) async {
  final snapshot = await FirebaseFirestore.instance
      .collection(usersCollection)
      .doc(uid)
      .get();

  return snapshot.data()!['userType'] != null;
}

String getUid() => FirebaseAuth.instance.currentUser!.uid;
