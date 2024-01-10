part of 'auth_bloc.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class LoginLoading extends AuthState {}
class RegisterLoading extends AuthState {}

class LoginSuccess extends AuthState {}
class RegisterSuccess extends AuthState {}

class SignOutLoading extends AuthState{}
class SignOutSuccess extends AuthState{}

class AuthError extends AuthState {
  final String error;

  AuthError(this.error);
}
