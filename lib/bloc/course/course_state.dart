part of 'course_bloc.dart';

@immutable
abstract class CourseState {}

class CourseInitial extends CourseState {}

class AddingCourseLoading extends CourseState{}
class AddingCourseLoaded extends CourseState{}
class AddingCourseError extends CourseState{}
