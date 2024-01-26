import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:quiz_app_new/utils/constants.dart';

import '../../utils/common_functions.dart';

part 'user_profile.g.dart';

enum UserType { student, teacher }

@JsonSerializable()
class UserProfile extends Equatable {
  @JsonKey(
    fromJson: dateTimeFromTimestamp,
    toJson: dateTimeToTimestamp,
  )
  final DateTime createdAt;
  final String userId;
  final String email;
  @JsonKey(includeIfNull: false)
  final String? firstName;
  @JsonKey(includeIfNull: false)
  final String? lastName;
  @JsonKey(includeIfNull: false)
  final String? phoneNumber;
  @JsonKey(
    toJson: usertypeToJson,
    fromJson: userTypeFromJson,
    includeIfNull: false,
  )
  final UserType? userType;
  final String? photoUrl;

  const UserProfile({
    required this.createdAt,
    required this.userId,
    this.firstName,
    required this.email,
    this.lastName,
    this.phoneNumber,
    this.userType,
    this.photoUrl = dummyProfilePicUrl,
  });

  UserProfile copyWith({
    String? firstName,
    String? lastName,
    String? phoneNumber,
    UserType? userType,
    String? photoUrl,
  }) {
    return UserProfile(
        createdAt: createdAt,
        userId: userId,
        email: email,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        photoUrl: photoUrl ?? this.photoUrl);
  }

  Map<String, dynamic> toJson() => _$UserProfileToJson(this);

  factory UserProfile.fromJson(Map<String, dynamic> json) =>
      _$UserProfileFromJson(json);

  factory UserProfile.fromGoogle(UserCredential credential) {
    return UserProfile(
      createdAt: DateTime.now(),
      userId: credential.user!.uid,
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
