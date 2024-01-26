part of 'user_info_bloc.dart';


abstract class UserInfoState {}

class UserInfoInitial extends UserInfoState {}

class UserInfoLoading extends UserInfoState {

}

class UserInfoLoaded extends UserInfoState {
  final UserProfile user;

  UserInfoLoaded(this.user);
}

class UserInfoUpdating extends UserInfoState {}
class UserInfoUpdated extends UserInfoState {}

class UserInfoError extends UserInfoState {
  final String error;

  UserInfoError(this.error);
}
