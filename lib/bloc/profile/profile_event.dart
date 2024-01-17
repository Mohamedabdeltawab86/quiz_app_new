part of 'profile_bloc.dart';

abstract class ProfileEvent {
  const ProfileEvent();
}
class DataRequested extends ProfileEvent{}

class ProfileImageUpdatedEvent extends ProfileEvent{
  final File file;
  const ProfileImageUpdatedEvent(this.file);
}
