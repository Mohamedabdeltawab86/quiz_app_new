part of 'path_bloc.dart';

@immutable
abstract class PathState {}

class PathInitial extends PathState {}


class PathLoading extends PathState {}
class PathLoaded extends PathState {
  final List<Path> paths;

  PathLoaded(this.paths);
  
}

class PathError extends PathState {
  final String message;

  PathError(this.message);
}

class PathUpdated extends PathState {
  final Path path;

  PathUpdated(this.path);
}

class StudentSubscribingPath extends PathState {}
class StudentSubscribedPath extends PathState {}
class StudentSubscribingErrorPath extends PathState {}



