part of 'enrolled_bloc.dart';

@immutable
abstract class EnrolledEvent {}

class FetchEnrolledCourses extends EnrolledEvent {}

class SubscribeToTeacher extends EnrolledEvent {
  // final List<Course> teacherCourses;
  final String teacherId;

  SubscribeToTeacher(this.teacherId);
}

class EnrollCourse extends EnrolledEvent {
  final String courseId;

  EnrollCourse(this.courseId);
}
