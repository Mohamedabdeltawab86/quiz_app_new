part of 'enrolled_bloc.dart';

@immutable
abstract class EnrolledState {}

class EnrolledInitial extends EnrolledState {}

class EnrolledCourseFetching extends EnrolledState {}

class EnrolledCourseFetched extends EnrolledState {
  final List<Course> courses;

  EnrolledCourseFetched(this.courses);
}

class EnrolledCourseFetchingError extends EnrolledState {
  final String message;

  EnrolledCourseFetchingError(this.message);
}

class SubscribeToTeacherFetching extends EnrolledState {}

class SubscribeToTeacherSuccess extends EnrolledState {}

class SubscribeToTeacherAlreadySubscribed extends EnrolledState {}

class SubscribeToTeacherError extends EnrolledState {
  final String message;

  SubscribeToTeacherError(this.message);
}

class EnrolledCourseSuccess extends EnrolledState {}

class EnrolledCourseError extends EnrolledState {
  final String message;

  EnrolledCourseError(this.message);
}
