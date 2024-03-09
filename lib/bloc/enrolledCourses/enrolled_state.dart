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

class EnrollMyTeacherCoursesFetching extends EnrolledState {}

class EnrollMyTeacherCoursesSuccess extends EnrolledState {}

class EnrollMyTeacherCoursesAlreadySubscribed extends EnrolledState {}

class EnrollMyTeacherCoursesError extends EnrolledState {
  final String message;

  EnrollMyTeacherCoursesError(this.message);
}

class EnrolledCourseSuccess extends EnrolledState {}

class EnrolledCourseError extends EnrolledState {
  final String message;

  EnrolledCourseError(this.message);
}
