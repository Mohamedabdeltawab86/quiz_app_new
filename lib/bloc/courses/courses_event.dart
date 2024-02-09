part of 'courses_bloc.dart';

@immutable
abstract class CoursesEvent {}

class AddCourse extends CoursesEvent {}

class FetchCourses extends CoursesEvent {}
class SelectCourse extends CoursesEvent{
  final Course course;

  SelectCourse(this.course);
}
class AddLesson extends CoursesEvent {
  final int moduleIndex;
  AddLesson(this.moduleIndex);
}

class AddModule extends CoursesEvent {}

class DeleteModule extends CoursesEvent {
  final int index;

  DeleteModule(this.index);
}

class DeleteLesson extends CoursesEvent {
  final int moduleIndex;
  final int lessonIndex;

  DeleteLesson({required this.moduleIndex, required this.lessonIndex});
}
