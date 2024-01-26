import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:quiz_app_new/utils/common_functions.dart';

import '../../data/models/user_profile.dart';
import '../../utils/constants.dart';

part 'user_info_event.dart';

part 'user_info_state.dart';

class UserInfoBloc extends Bloc<UserInfoEvent, UserInfoState> {
  final User? userId;

  UserInfoBloc(this.userId) : super(UserInfoInitial()) {
    on<LoadingProfileEvent>(_loadUserInfo);
    on<UpdateProfileEvent>(_updateUserInfo);
  }

  void _loadUserInfo(
    LoadingProfileEvent event,
    Emitter<UserInfoState> emit,
  ) async {
    emit(UserInfoLoading());
    DocumentSnapshot userData = await readUserFromDB(userId!);
    // DocumentSnapshot userData = await FirebaseFirestore.instance
    //     .collection(usersCollection)
    //     .doc(userId?.uid)
    //     .get();
    UserProfile userProfile =
        UserProfile.fromJson(userData as Map<String, dynamic>);
    print(userProfile);
    emit(UserInfoLoaded(userProfile));
  }

  Future<void> _updateUserInfo(
      UpdateProfileEvent event, Emitter<UserInfoState> emit) async {
    emit(UserInfoUpdating());
    // emit(UserInfoLoaded(UserProfile: ));
  }
}
