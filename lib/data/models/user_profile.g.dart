// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserProfile _$UserProfileFromJson(Map<String, dynamic> json) => UserProfile(
      createdAt: dateTimeFromTimestamp(json['createdAt'] as Timestamp),
      userId: json['userId'] as String,
      firstName: json['firstName'] as String?,
      email: json['email'] as String,
      lastName: json['lastName'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      userType: UserProfile.userTypeFromJson(json['userType']),
      photoUrl: json['photoUrl'] as String?,
    );

Map<String, dynamic> _$UserProfileToJson(UserProfile instance) {
  final val = <String, dynamic>{
    'createdAt': dateTimeToTimestamp(instance.createdAt),
    'userId': instance.userId,
    'email': instance.email,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('firstName', instance.firstName);
  writeNotNull('lastName', instance.lastName);
  writeNotNull('phoneNumber', instance.phoneNumber);
  writeNotNull('userType', UserProfile.usertypeToJson(instance.userType));
  val['photoUrl'] = instance.photoUrl;
  return val;
}
