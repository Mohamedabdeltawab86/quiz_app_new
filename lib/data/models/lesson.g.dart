// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lesson.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Lesson _$LessonFromJson(Map<String, dynamic> json) => Lesson(
      id: json['id'] as int,
      title: json['title'] as String,
      content: json['content'] as String,
      createdAt: dateTimeFromTimestamp(json['createdAt'] as Timestamp),
      updatedAt: dateTimeFromTimestamp(json['updatedAt'] as Timestamp),
    );

Map<String, dynamic> _$LessonToJson(Lesson instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'content': instance.content,
      'createdAt': dateTimeToTimestamp(instance.createdAt),
      'updatedAt': dateTimeToTimestamp(instance.updatedAt),
    };
