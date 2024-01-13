// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Course _$CourseFromJson(Map<String, dynamic> json) => Course(
      id: json['id'] as int,
      title: json['title'] as String?,
      description: json['description'] as String?,
      imageUrl: json['imageUrl'] as String?,
      instructorId: json['instructorId'] as int,
      moduleIds:
          (json['moduleIds'] as List<dynamic>).map((e) => e as String).toList(),
      createdAt: Course._dateTimeFromTimestamp(json['createdAt'] as Timestamp),
      updatedAt: Course._dateTimeFromTimestamp(json['updatedAt'] as Timestamp),
    );

Map<String, dynamic> _$CourseToJson(Course instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'imageUrl': instance.imageUrl,
      'instructorId': instance.instructorId,
      'moduleIds': instance.moduleIds,
      'createdAt': Course._dateTimeToTimestamp(instance.createdAt),
      'updatedAt': Course._dateTimeToTimestamp(instance.updatedAt),
    };
