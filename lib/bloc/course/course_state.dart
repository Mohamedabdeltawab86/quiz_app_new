part of 'course_bloc.dart';

@immutable
abstract class CourseState {}

class CourseInitial extends CourseState {}

class AddingCourseLoading extends CourseState {}

class AddingCourseDone extends CourseState {}

class AddingCourseError extends CourseState {}

class CourseFetching extends CourseState {}

class CourseFetched extends CourseState {}

class CourseFetchError extends CourseState {}
