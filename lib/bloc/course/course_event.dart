part of 'course_bloc.dart';

@immutable
abstract class CourseEvent {}

class AddCourse extends CourseEvent {}

class FetchCourses extends CourseEvent {}

class AddLesson extends CourseEvent {
  final int moduleIndex;
  AddLesson(this.moduleIndex);
}

class AddModule extends CourseEvent {}

class DeleteModule extends CourseEvent {
  final int index;

  DeleteModule(this.index);
}

class DeleteLesson extends CourseEvent {
  final int moduleIndex;
  final int lessonIndex;

  DeleteLesson({required this.moduleIndex, required this.lessonIndex});
}
