part of 'enrolled_bloc.dart';

@immutable
abstract class EnrolledEvent {}

class FetchEnrolledCourses extends EnrolledEvent {}

class ChangeIsPathValue extends EnrolledEvent {}

class SubscribeToCode extends EnrolledEvent {
  final String code;

  SubscribeToCode(this.code);
}

class EnrollCourse extends EnrolledEvent {
  final String courseId;

  EnrollCourse(this.courseId);
}
