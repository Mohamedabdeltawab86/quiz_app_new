part of 'course_bloc.dart';

@immutable
abstract class CourseState {}

class CourseInitial extends CourseState {}

class AddingCourseLoading extends CourseState{}
class AddingCourseLoaded extends CourseState{}
class AddingCourseError extends CourseState{}

class CourseFetchingState extends CourseState{}
class CourseFetchedState extends CourseState{
final List<Course> courses;

  CourseFetchedState(this.courses);

}
class CourseFetchError extends CourseState{}


