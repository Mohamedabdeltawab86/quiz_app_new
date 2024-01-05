part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class LoginWithUserPassword extends AuthEvent {}

class LoginWithGoogle extends AuthEvent {}

class RegisterwithEmailPassword extends AuthEvent{}
