import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_sign_in/google_sign_in.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<LoginWithUserPassword>(_onEmailPasswordLogin);
    on<LoginWithGoogle>(_onGoogleLogin);
    on<RegisterwithEmailPassword>(_onEmailPasswordRegister);
  }

  final emailController = TextEditingController();
  final passController = TextEditingController();

  void _onEmailPasswordRegister(
      AuthEvent event, Emitter<AuthState> emit) async {
    emit(LoginLoading());
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passController.text,
      );
      emit(LoginSuccess());
    } catch (e) {
      if (e is FirebaseAuthException) {
        final String eMessage =
            e.message ?? "Unknown Firebase Auth Exception happened";
        emit(LoginError(eMessage));
        EasyLoading.showError(eMessage);
      } else {
        emit(LoginError("Unknown Error"));
      }
    }
  }

  void _onEmailPasswordLogin(
    LoginWithUserPassword event,
    Emitter<AuthState> emit,
  ) async {
    emit(LoginLoading());
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passController.text,
      );
      emit(LoginSuccess());
    } catch (e) {
      if (e is FirebaseAuthException) {
        final String eMessage =
            e.message ?? "Unknown Firebase Auth Exception happened";
        emit(LoginError(eMessage));
        EasyLoading.showError(eMessage);
      } else {
        emit(LoginError("Unknown Error happened"));
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
      UserCredential loginData =
          await FirebaseAuth.instance.signInWithCredential(credential);

      // TODO: create entry in firestore
      loginData.user!.uid;
      emit(LoginSuccess());
      await FirebaseFirestore.instance
          .collection('users')
          .doc(loginData.user!.uid)
          .set({
        'uid': loginData.user!.uid,
        'email': loginData.user!.email,
        'user': loginData.user!.displayName,
      });
      emit(LoginSuccess());
    } catch (e) {
      if (e is FirebaseAuthException) {
        final String eMessage =
            e.message ?? "Unknown Firebase Auth Exception happened";
        emit(LoginError(eMessage));
        EasyLoading.showError(eMessage);
      } else {
        print(e.toString());
        emit(LoginError("Unknown Error happened"));
      }
    }
  }

  @override
  Future<void> close() {
    emailController.dispose();
    passController.dispose();
    return super.close();
  }
}
