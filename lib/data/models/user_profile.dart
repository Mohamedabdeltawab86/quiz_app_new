import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:quiz_app_new/utils/constants.dart';

import '../../utils/common_functions.dart';

part 'user_profile.g.dart';

enum UserType { student, teacher }

@JsonSerializable(includeIfNull: false)
class UserProfile extends Equatable {
  @JsonKey(
    fromJson: dateTimeFromTimestamp,
    toJson: dateTimeToTimestamp,
  )
  final DateTime? createdAt;
  final String? userId;
  final String? email;
  final String? firstName;
  final String? lastName;
  final String? phoneNumber;
  @JsonKey(
    toJson: usertypeToJson,
    fromJson: userTypeFromJson,
  )
  final UserType? userType;
  final String? photoUrl;
  final List<String> subscribedCourses;

  const UserProfile({
    this.createdAt,
    this.userId,
    this.firstName,
    this.email,
    this.lastName,
    this.phoneNumber,
    this.userType,
    this.photoUrl = dummyProfilePicUrl,
    this.subscribedCourses = const [],
  });

  UserProfile copyWith({
    String? firstName,
    String? lastName,
    String? phoneNumber,
    UserType? userType,
    String? photoUrl,
    List<String>? subscribedCourses,
  }) {
    return UserProfile(
      createdAt: createdAt,
      userId: userId,
      email: email,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      photoUrl: photoUrl ?? this.photoUrl,
      subscribedCourses: subscribedCourses ?? this.subscribedCourses,
    );
  }

  Map<String, dynamic> toJson() => _$UserProfileToJson(this);

  factory UserProfile.fromJson(Map<String, dynamic> json) =>
      _$UserProfileFromJson(json);

  factory UserProfile.fromGoogle(UserCredential credential) {
    return UserProfile(
      createdAt: DateTime.now(),
      userId: getUid(),
      email: credential.user!.email!,
      photoUrl: credential.user!.photoURL,
    );
  }

  static String? usertypeToJson(UserType? userType) => userType?.name;

  static UserType? userTypeFromJson(userType) {
    switch (userType) {
      case "teacher":
        return UserType.teacher;
      case "student":
        return UserType.student;
      default:
        return null;
    }
  }

  @override
  List<Object?> get props => [
        userId,
        lastName,
        lastName,
        phoneNumber,
        userType,
        photoUrl,
      ];
}
