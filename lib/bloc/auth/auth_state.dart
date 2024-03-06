part of 'auth_bloc.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class LoginLoading extends AuthState {}

class RegisterLoading extends AuthState {}

class LoginSuccess extends AuthState {
  final bool hasInfo;

  LoginSuccess({required this.hasInfo});
}

class RegisterSuccess extends AuthState {
  final bool hasInfo;

  RegisterSuccess({required this.hasInfo});
}

class SignOutLoading extends AuthState {}

class SignOutSuccess extends AuthState {}

class UserInfoUpdated extends AuthState {}

class AuthError extends AuthState {
  final String error;

  AuthError(this.error);
}

class EmailVerificationSent extends AuthState{}
