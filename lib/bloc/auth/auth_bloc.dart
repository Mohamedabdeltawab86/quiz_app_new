import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:quiz_app_new/utils/common_functions.dart';

import '../../data/models/user_profile.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<RegisterWithEmailPassword>(_onEmailPasswordRegister);
    on<LoginWithUserPassword>(_onEmailPasswordLogin);
    on<LoginWithGoogle>(_onGoogleLogin);
    on<SignOut>(_onSignOut);
    on<ChangeType>(_changeUserType);
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
  // make user type a student as default to be shown in create account page,
  UserType? userType = UserType.student;

  void _onEmailPasswordRegister(
      AuthEvent event, Emitter<AuthState> emit) async {
    if (registerFormKey.currentState!.validate()) {
      emit(RegisterLoading());
      try {
        final UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailRegisterController.text,
          password: passRegisterController.text,
        );
        userCredential.user?.sendEmailVerification();
        await saveUserInDB(
          UserProfile(
            userId: getUid(),
            firstName: firstNameController.text,
            lastName: lastNameController.text,
            phoneNumber: phoneNumberController.text,
            email: emailRegisterController.text,
            userType: userType,
            createdAt: DateTime.now(),
          ),
        );

      } on FirebaseException catch (e) {
        if (e.code == 'weak-password') {
          const String message = 'The password provided is too weak.';
          emit(AuthError(message));
          EasyLoading.showError(message);
        } else if (e.code == 'email-already-in-use') {
          const String message = 'The account already exists for that email.';
          emit(AuthError(message));
          EasyLoading.showError(message);
        }
        emit(RegisterSuccess(hasInfo: true));
      } catch (e) {
        emit(AuthError(e.toString()));
        log(e.toString());
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
      } on FirebaseException catch (e) {
        if (e.code == 'user-not-found') {
          const String message = 'No user found for that email.';
          emit(AuthError(message));
          EasyLoading.showError(message);
        } else if (e.code == 'wrong-password') {
          const String message = 'Wrong password provided for that user.';
          emit(AuthError(message));
          EasyLoading.showError(message);
        }
      } catch (e) {
        emit(AuthError(e.toString()));
        EasyLoading.showError(e.toString());
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
      bool hasData = await doesUserHasInfo();
      // TODO: if user doesn't have info, go to user info screen ONLY to update the user type.
      emit(LoginSuccess(hasInfo: hasData));
    } on FirebaseException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
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

  Future<void> _onSignOut(
    SignOut event,
    Emitter<AuthState> emit,
  ) async {
    emit(SignOutLoading());
    await FirebaseAuth.instance.signOut();
    emit(SignOutSuccess());
  }

  Future<void> _changeUserType(
    ChangeType event,
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
      UserProfile userProfile = UserProfile(userType: userType);
      await saveUserInDB(userProfile);
      emit(UserInfoUpdated());
    }
  }
  Future<void> sendEmailVerification(User user) async{
    if (!user.emailVerified){
      await user.sendEmailVerification();
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
