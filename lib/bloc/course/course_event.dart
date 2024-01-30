part of 'course_bloc.dart';

@immutable
abstract class CourseEvent {}

class AddCourse extends CourseEvent {}

class FetchCourses extends CourseEvent {}

class AddLesson extends CourseEvent {}

class DeleteLesson extends CourseEvent {
  final int index;
  DeleteLesson(this.index);
}
