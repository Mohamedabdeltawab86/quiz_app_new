import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:quiz_app_new/data/models/user_profile.dart';
import 'package:quiz_app_new/utils/routes.dart';

import '../data/models/course.dart';
import '../data/models/lesson.dart';
import '../data/models/module.dart';
import '../data/models/question.dart';
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
      .set(profile.toJson(), SetOptions(merge: true));
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

Future<List<Module>> getModules(String courseId) async {
  QuerySnapshot modules = await FirebaseFirestore.instance
      .collection(coursesCollection)
      .doc(courseId)
      .collection(modulesCollection)
      .orderBy('title')
      .get();
  List<Module> moduleData = modules.docs
      .map((doc) => Module.fromJson(doc.data() as Map<String, dynamic>))
      .toList();
  return moduleData;
}

Future<List<Lesson>> getLessons(String courseId, String moduleId) async {
  QuerySnapshot lessons = (await FirebaseFirestore.instance
      .collection(coursesCollection)
      .doc(courseId)
      .collection(modulesCollection)
      .doc(moduleId)
      .collection(lessonCollection)
      .orderBy('title')
      .get());
  List<Lesson> lessonsData = lessons.docs
      .map((doc) => Lesson.fromJson(doc.data() as Map<String, dynamic>))
      .toList();
  return lessonsData;
}

Future<List<Question>> getQuestions(
    String courseId, String moduleId, String lessonId) async {
  QuerySnapshot questionsSnapshot = await FirebaseFirestore.instance
      .collection(coursesCollection)
      .doc(courseId)
      .collection(modulesCollection)
      .doc(moduleId)
      .collection(lessonCollection)
      .doc(lessonId)
      .collection(questionCollection)
      .get();
  List<Question> questionsData = questionsSnapshot.docs
      .map((doc) => Question.fromJson(doc.data() as Map<String, dynamic>))
      .toList();

  return questionsData;
}

Future<void> saveQuestion(String courseId, String moduleId, String lessonId,
    Question question) async {
  final updatedQuestion = FirebaseFirestore.instance
      .collection(coursesCollection)
      .doc(courseId)
      .collection(modulesCollection)
      .doc(moduleId)
      .collection(lessonCollection)
      .doc(lessonId)
      .collection(questionCollection)
      .withConverter<Question>(
        fromFirestore: (snapshot, options) =>
            Question.fromJson(snapshot.data()!),
        toFirestore: (course, options) => course.toJson(),
      );
  await updatedQuestion.doc(question.id).set(question);
}

Future<void> saveLesson(String courseId, String moduleId, Lesson lesson) async {
  final updatedLesson = FirebaseFirestore.instance
      .collection(coursesCollection)
      .doc(courseId)
      .collection(modulesCollection)
      .doc(moduleId)
      .collection(lessonCollection)
      .withConverter<Lesson>(
        fromFirestore: (snapshot, options) => Lesson.fromJson(snapshot.data()!),
        toFirestore: (course, options) => course.toJson(),
      );
  await updatedLesson.doc(lesson.id).set(lesson);
}

Future<void> saveOneCourse(Course course) async {
  final updatedCourse = FirebaseFirestore.instance
      .collection(coursesCollection)
      .withConverter<Course>(
        fromFirestore: (snapshot, options) => Course.fromJson(snapshot.data()!),
        toFirestore: (course, options) => course.toJson(),
      );
  await updatedCourse.doc(course.id).set(course);
}

Future<void> saveCourseInDB(
    Course course, List<(Module, List<Lesson>)> modulesData) async {
  final courses = FirebaseFirestore.instance
      .collection(coursesCollection)
      .withConverter<Course>(
        fromFirestore: (snapshot, options) => Course.fromJson(snapshot.data()!),
        toFirestore: (course, options) => course.toJson(),
      );

  // step 1: adding the course
  await courses.doc(course.id).set(course);

  // step 2: adding the lessons inside the course sub collection
  final batch = FirebaseFirestore.instance.batch();
  final modulesReference = courses.doc(course.id).collection(modulesCollection);
  for (var moduleData in modulesData) {
    final moduleRef = modulesReference.doc(moduleData.$1.id);
    batch.set(moduleRef, moduleData.$1.toJson());
    for (Lesson lesson in moduleData.$2) {
      final lessonRef = moduleRef.collection(lessonCollection).doc(lesson.id);
      batch.set(lessonRef, lesson.toJson());
    }
  }
  await batch.commit();
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

  return snapshot.data()?['userType'] != null;
}

String getUid() => FirebaseAuth.instance.currentUser!.uid;

Future<String> getInitialLocation() async {
  if (FirebaseAuth.instance.currentUser != null) {
    if (await doesUserHasInfo(getUid())) {
      return home;
    }
    return userTypeAndInfo;
  } else {
    return login;
  }
}
