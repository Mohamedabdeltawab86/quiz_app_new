part of 'courses_bloc.dart';

@immutable
abstract class CoursesState {}

class CourseInitial extends CoursesState {}

class AddingCourseLoading extends CoursesState {}

class AddingCourseDone extends CoursesState {}

class AddingCourseError extends CoursesState {}

class CourseFetching extends CoursesState {}

class CourseFetched extends CoursesState {}

class CourseFetchError extends CoursesState {}

class LessonAdded extends CoursesState {}

class LessonDeleted extends CoursesState {}

class ModuleAdded extends CoursesState {}

class ModuleDeleted extends CoursesState {}

class DeletingCourseLoading extends CoursesState {}
class DeletingCourseSuccess extends CoursesState {}


