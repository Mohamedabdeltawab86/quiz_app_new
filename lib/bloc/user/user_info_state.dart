part of 'user_info_bloc.dart';


abstract class UserInfoState {}
// TODO 5: How to add fields and to and fromJson , child classes with need to pass them
class UserInfoInitial extends UserInfoState {}

class UserInfoLoading extends UserInfoState {}

class UserInfoLoaded extends UserInfoState {}

class UserInfoUpdating extends UserInfoState {}
class UserInfoUpdated extends UserInfoState {}

class UserInfoError extends UserInfoState {
  final String error;

  UserInfoError(this.error);
}
