import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:quiz_app_new/utils/common_functions.dart';

import '../../data/models/user_profile.dart';
import '../../utils/constants.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<LoginWithUserPassword>(_onEmailPasswordLogin);
    on<LoginWithGoogle>(_onGoogleLogin);
    on<RegisterWithEmailPassword>(_onEmailPasswordRegister);
    on<SignOut>(_onSignOut);
    on<TypeChanged>(_changeUserType);
    on<UserInfoSubmitted>(_submitUserInfo);
  }

  final emailController = TextEditingController();
  final passController = TextEditingController();
  final emailRegisterController = TextEditingController();
  final passRegisterController = TextEditingController();
  final passConfirmController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final registerFormKey = GlobalKey<FormState>();
  final userInfoKey = GlobalKey<FormState>();
  UserType userType = UserType.student;

  void _onEmailPasswordRegister(
      AuthEvent event, Emitter<AuthState> emit) async {
    if (registerFormKey.currentState!.validate()) {
      emit(RegisterLoading());
      try {
        final userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailRegisterController.text,
          password: passRegisterController.text,
        );

        await saveUserInDB(UserProfile(
          userId: userCredential.user!.uid,
          firstName: firstNameController.text,
          lastName: lastNameController.text,
          phoneNumber: phoneNumberController.text,
          email: emailRegisterController.text,
          userType: userType,
          updatedAt: DateTime.now(),
        ));
        emit(RegisterSuccess(hasInfo: true));
      } catch (e) {
        if (e is FirebaseAuthException) {
          final String eMessage =
              e.message ?? "Unknown Firebase Auth Exception happened";
          log("MESSAGE =============== $eMessage");
          emit(AuthError(eMessage));
          EasyLoading.showError(eMessage);
        } else {
          emit(AuthError("Unknown Error"));
        }
      }
    }
  }

  void _onEmailPasswordLogin(
    LoginWithUserPassword event,
    Emitter<AuthState> emit,
  ) async {
    if (formKey.currentState!.validate()) {
      emit(LoginLoading());
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text,
          password: passController.text,
        );
        emit(LoginSuccess(hasInfo: true));
      } catch (e) {
        if (e is FirebaseAuthException) {
          final String eMessage =
              e.message ?? "Unknown Firebase Auth Exception happened";
          emit(AuthError(eMessage));
          EasyLoading.showError(eMessage);
        } else {
          emit(AuthError("Unknown Error happened"));
        }
      }
    }
  }

  void _onGoogleLogin(
    LoginWithGoogle event,
    Emitter<AuthState> emit,
  ) async {
    emit(LoginLoading());
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      await saveUserInDB(UserProfile.fromGoogle(userCredential));
      emit(LoginSuccess(hasInfo: true));
    } catch (e) {
      if (e is FirebaseAuthException) {
        final String eMessage =
            e.message ?? "Unknown Firebase Auth Exception happened";
        emit(AuthError(eMessage));
        EasyLoading.showError(eMessage);
      } else {
        print(e.toString());
        emit(AuthError("Unknown Error happened"));
      }
    }
  }

  Future<bool> doesUserHasInfo(String uid) async {
    final snapshot = await FirebaseFirestore.instance
        .collection(usersCollection)
        .doc(uid)
        .get();

    return snapshot.data()!['userType'];
  }

  Future<void> _onSignOut(
    SignOut event,
    Emitter<AuthState> emit,
  ) async {
    emit(SignOutLoading());
    await FirebaseAuth.instance.signOut();
    emit(SignOutSuccess());
  }

  Future<void> _changeUserType(
    TypeChanged event,
    Emitter<AuthState> emit,
  ) async {
    userType = event.userType;
    emit(UserInfoUpdated());
  }

  Future<void> _submitUserInfo(
    UserInfoSubmitted event,
    Emitter<AuthState> emit,
  ) async {
    // TODO: complete
    if (userInfoKey.currentState!.validate()) {
      UserProfile userProfile = UserProfile(
        userId: FirebaseAuth.instance.currentUser!.uid,
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        phoneNumber: phoneNumberController.text,
        userType: userType,
        email: FirebaseAuth.instance.currentUser!.email!,
        updatedAt: DateTime.now()
      );
      await saveUserInDB(userProfile);
      emit(UserInfoUpdated());
    }
  }

  @override
  Future<void> close() {
    emailController.dispose();
    passController.dispose();
    emailRegisterController.dispose();
    passRegisterController.dispose();
    passConfirmController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    phoneNumberController.dispose();
    return super.close();
  }
}
