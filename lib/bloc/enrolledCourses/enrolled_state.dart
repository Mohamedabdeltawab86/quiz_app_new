part of 'enrolled_bloc.dart';

@immutable
abstract class EnrolledState {}

class EnrolledInitial extends EnrolledState {}

class EnrolledCourseFetching extends EnrolledState {}

class EnrolledCourseFetched extends EnrolledState {}

class EnrolledCourseFetchingError extends EnrolledState {
  final String message;

  EnrolledCourseFetchingError(this.message);
}

class SubscribeToCodeLoading extends EnrolledState {}

class SubscribeToCodeSuccess extends EnrolledState {}

class SubscribeToCodeError extends EnrolledState {
  final String message;

  SubscribeToCodeError(this.message);
}

class IsPathValueChanged extends EnrolledState {}

class EnrolledCourseSuccess extends EnrolledState {}

class EnrolledCourseError extends EnrolledState {
  final String message;

  EnrolledCourseError(this.message);
}
