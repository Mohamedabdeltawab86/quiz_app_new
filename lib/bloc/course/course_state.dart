part of 'course_bloc.dart';

@immutable
abstract class CourseState {}

class CourseInitial extends CourseState {}

class ModulesLoaded extends CourseState {
  final List<Module> modules;

  ModulesLoaded(this.modules);
}

class ModulesLoading extends CourseState {}

class DeletingModuleLoading extends CourseState {}


class LessonLoading extends CourseState{}

class LessonLoaded extends CourseState{
  final List<Lesson> lessons;

  LessonLoaded(this.lessons);
}
