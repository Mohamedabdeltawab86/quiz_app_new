part of 'course_bloc.dart';

@immutable
abstract class CourseEvent {}

class LoadModules extends CourseEvent {}

class DeleteModule extends CourseEvent {
  final String moduleID;

  DeleteModule({required this.moduleID});
}
