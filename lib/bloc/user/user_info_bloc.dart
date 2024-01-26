import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:quiz_app_new/utils/common_functions.dart';

import '../../data/models/user_profile.dart';
import '../../utils/constants.dart';

part 'user_info_event.dart';

part 'user_info_state.dart';

class UserInfoBloc extends Bloc<UserInfoEvent, UserInfoState> {
  final String userId;

  UserInfoBloc(this.userId) : super(UserInfoInitial()) {
    on<LoadingProfileEvent>(_loadUserInfo);
    on<UpdateProfileEvent>(_updateUserInfo);
  }

  void initInfoPage() {}

  void _loadUserInfo(
    LoadingProfileEvent event,
    Emitter<UserInfoState> emit,
  ) async {
    try {
      print(userId);
      emit(UserInfoLoading());
      DocumentSnapshot userData = await readUserFromDB(userId);

      if (userData.exists) {
        Map<String, dynamic> userDataMap =
            userData.data() as Map<String, dynamic>;
        UserProfile userProfile = UserProfile.fromJson(userDataMap);
        print(userProfile);
        emit(UserInfoLoaded(userProfile));
      } else {
        emit(UserInfoError("User NOT fOUND"));
      }
    } catch (e) {
      emit(UserInfoError(e.toString()));
    }
  }

  Future<void> _updateUserInfo(
      UpdateProfileEvent event, Emitter<UserInfoState> emit) async {
    emit(UserInfoUpdating());
    // emit(UserInfoLoaded(UserProfile: ));
  }
}
