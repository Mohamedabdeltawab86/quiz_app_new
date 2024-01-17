import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
class StorageRepo{
  final storage = FirebaseStorage.instance.ref();

  StorageRepo();
  Future<String?> uploadUsersProfileFile(File file) async{
    final user = FirebaseAuth.instance.currentUser;
    var profileImagePath = "users/profile/${user!.uid}";
    var storageRef = storage.child(profileImagePath) ;
    try{
      await storageRef.putFile(file);
      return storageRef.child(profileImagePath).getDownloadURL();
    }
    on FirebaseException catch (e){
      debugPrint("Firebase Exception :$e");
    }
    return null;

  }
}