import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import '../../data/repositories/storage_repo.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

part 'profile_event.dart';

part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final StorageRepo repository;

  ProfileBloc({required this.repository}) : super(ProfileLoadingState()) {
    on<DataRequested>(_onDataRequested);
    on<ProfileImageUpdatedEvent>(_onProfileImageUpdate);
  }

  Future<void> _onDataRequested(
      DataRequested event, Emitter<ProfileState> emit) async {
    emit(ProfileLoadingState());
    try {
      bool result = await checkConnectivity();
      if (result) {
        emit(ProfileSuccessState(FirebaseAuth.instance.currentUser!));
      } else {
        emit(const ProfileError(
            "No internet connection. Please try again later."));
      }
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

  Future<void> _onProfileImageUpdate(
      ProfileImageUpdatedEvent event, Emitter<ProfileState> emit) async {
    emit(ProfileLoadingState());
    try {
      bool result = await checkConnectivity();
      if (result) {
        var downloadUrl = await repository.uploadUsersProfileFile(event.file);
        debugPrint('profile_bloc: $downloadUrl');
        emit(ProfileUpdateState(
            downloadUrl!, FirebaseAuth.instance.currentUser!));
      } else {
        emit(const ProfileError(
            "No internet connection. Please try again later."));
      }
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

  Future<bool> checkConnectivity() async {
    bool result = await InternetConnectionChecker().hasConnection;
    return result;
  }
}
