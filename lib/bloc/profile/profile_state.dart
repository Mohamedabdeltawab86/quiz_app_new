part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();
}

class ProfileLoadingState extends ProfileState {
  @override
  List<Object> get props => [];
}

class ProfileSuccessState extends ProfileState {
  final User user;
  const ProfileSuccessState(this.user);

  @override
  List<Object?> get props => [user.photoURL];
}

class ProfileUpdateState extends ProfileSuccessState {
  final String url;
  const ProfileUpdateState(this.url, user): super(user);

  @override
  List<Object?> get props => [url];
}

class ProfileError extends ProfileState {
  final String error;
  const ProfileError(this.error);

  @override
  List<Object?> get props => [error];
}
