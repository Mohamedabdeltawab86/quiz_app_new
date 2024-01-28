part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class LoginWithUserPassword extends AuthEvent {}

class LoginWithGoogle extends AuthEvent {}

class RegisterWithEmailPassword extends AuthEvent{}

class SignOut extends AuthEvent{}

class ChangeType extends AuthEvent{
  final UserType? userType;
  ChangeType(this.userType);
}

class UserInfoSubmitted extends AuthEvent{}
