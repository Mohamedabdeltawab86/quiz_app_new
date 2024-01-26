part of 'user_info_bloc.dart';


abstract class UserInfoEvent {}

class LoadingProfileEvent extends UserInfoEvent{}
class UpdateProfileEvent extends UserInfoEvent{}