part of 'user_info_bloc.dart';


abstract class UserInfoEvent {}

class LoadProfile extends UserInfoEvent{}
class UpdateProfile extends UserInfoEvent{}