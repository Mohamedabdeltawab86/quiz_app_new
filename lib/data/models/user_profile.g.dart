// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserProfile _$UserProfileFromJson(Map<String, dynamic> json) => UserProfile(
      createdAt: dateTimeFromTimestamp(json['createdAt'] as Timestamp),
      userId: json['userId'] as String?,
      firstName: json['firstName'] as String?,
      email: json['email'] as String?,
      lastName: json['lastName'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      userType: UserProfile.userTypeFromJson(json['userType']),
      photoUrl: json['photoUrl'] as String? ?? dummyProfilePicUrl,
      subscribedCourses: (json['subscribedCourses'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$UserProfileToJson(UserProfile instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('createdAt', dateTimeToTimestamp(instance.createdAt));
  writeNotNull('userId', instance.userId);
  writeNotNull('email', instance.email);
  writeNotNull('firstName', instance.firstName);
  writeNotNull('lastName', instance.lastName);
  writeNotNull('phoneNumber', instance.phoneNumber);
  writeNotNull('userType', UserProfile.usertypeToJson(instance.userType));
  writeNotNull('photoUrl', instance.photoUrl);
  val['subscribedCourses'] = instance.subscribedCourses;
  return val;
}
