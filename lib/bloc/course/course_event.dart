part of 'course_bloc.dart';

@immutable
abstract class CourseEvent {}

class LoadModules extends CourseEvent {}
class LoadLessons extends CourseEvent {
  final String moduleID;

  LoadLessons(this.moduleID);
}

class DeleteModule extends CourseEvent {
  final String moduleID;

  DeleteModule({required this.moduleID});
}
