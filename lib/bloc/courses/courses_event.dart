part of 'courses_bloc.dart';

@immutable
abstract class CoursesEvent {}

class AddCourse extends CoursesEvent {}

class FetchCourses extends CoursesEvent {}

class AddLesson extends CoursesEvent {
  final int moduleIndex;

  AddLesson(this.moduleIndex);
}

class AddModule extends CoursesEvent {}

class InitCourse extends CoursesEvent {
  final Course course;
  InitCourse(this.course);
}

class DeleteCourse extends CoursesEvent {
  final String courseId;

  DeleteCourse(this.courseId);
}

class DeleteModule extends CoursesEvent {
  final int index;

  DeleteModule(this.index);
}

class DeleteLesson extends CoursesEvent {
  final int moduleIndex;
  final int lessonIndex;

  DeleteLesson({required this.moduleIndex, required this.lessonIndex});
}
