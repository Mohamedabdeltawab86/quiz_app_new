// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lesson.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Lesson _$LessonFromJson(Map<String, dynamic> json) => Lesson(
      id: json['id'] as int,
      title: json['title'] as String,
      content: json['content'] as String,
      createdAt: Lesson._dateTimeFromTimestamp(json['createdAt'] as Timestamp),
      updatedAt: Lesson._dateTimeFromTimestamp(json['updatedAt'] as Timestamp),
    );

Map<String, dynamic> _$LessonToJson(Lesson instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'content': instance.content,
      'createdAt': Lesson._dateTimeToTimestamp(instance.createdAt),
      'updatedAt': Lesson._dateTimeToTimestamp(instance.updatedAt),
    };
