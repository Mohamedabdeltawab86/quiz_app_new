import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:quiz_app_new/utils/common_functions.dart';

import '../../data/models/user_profile.dart';

part 'user_info_event.dart';

part 'user_info_state.dart';

class UserInfoBloc extends HydratedBloc<UserInfoEvent, UserInfoState> {
  UserInfoBloc() : super(UserInfoInitial()) {
    on<LoadProfile>(_loadUserInfo);
    on<UpdateProfile>(_updateUserInfo);
  }

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final profileFormKey = GlobalKey<FormState>();

  void initInfoPage(UserProfile profile) {
    firstNameController.text = profile.firstName ?? "";
    lastNameController.text = profile.lastName ?? "";
    phoneNumberController.text = profile.phoneNumber ?? "";
  }

  void _loadUserInfo(LoadProfile event,
      Emitter<UserInfoState> emit,) async {
    try {
      emit(UserInfoLoading());
      // todo use hydrated 1
      UserProfile profile = await readUserFromDB();
      initInfoPage(profile);
      emit(UserInfoLoaded());
    } catch (e) {
      emit(UserInfoError(e.toString()));
    }
  }

  Future<void> _updateUserInfo(UpdateProfile event,
      Emitter<UserInfoState> emit) async {
    emit(UserInfoUpdating());
    final updatedProfile = UserProfile(
      firstName: firstNameController.text,
      lastName: lastNameController.text,
      phoneNumber: phoneNumberController.text,
    );
    await saveUserInDB(updatedProfile);
    emit(UserInfoUpdated());
  }

  @override
  Future<void> close() {
    firstNameController.dispose();
    lastNameController.dispose();
    phoneNumberController.dispose();
    return super.close();
  }

  @override
  UserInfoState? fromJson(Map<String, dynamic> json) {

  }

  @override
  Map<String, dynamic>? toJson(UserInfoState state) {

  }
}