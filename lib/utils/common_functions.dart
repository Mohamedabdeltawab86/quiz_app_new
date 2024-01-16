import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'constants.dart';

String? isValidEmail(String? email, String message) {
  final regex = RegExp(
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");
  if (email != null && regex.hasMatch(email)) {
    return null;
  } else {
    return message;
  }
}

String? isValidPassword(String? password, String message) {
  if (password != null && password.length >= 8) {
    return null;
  } else {
    return message;
  }
}

String? isSamePassword({
  required String pass,
  required String passConfirm,
  required String emptyMessage,
  required String mismatchMessage,
}) {
  if (pass.isEmpty && passConfirm.isEmpty) {
    return emptyMessage;
  } else if (pass != passConfirm) {
    return mismatchMessage;
  }
  return null;
}

Future<void> saveUserInDB(UserCredential userCredential) async {
  await FirebaseFirestore.instance
      .collection(usersCollection)
      .doc(userCredential.user!.uid)
      .set(
    {
      'uid': userCredential.user!.uid,
      'email': userCredential.user!.email,
      'user': userCredential.user!.displayName,
    },
  );
}
