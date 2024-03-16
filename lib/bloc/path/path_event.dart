part of 'path_bloc.dart';

@immutable
abstract class PathEvent {}

class FetchPath extends PathEvent {}
class CreatePath extends PathEvent {}
class UpdatePath extends PathEvent {}
class DeletePath extends PathEvent {}
class SubscribePath extends PathEvent {}