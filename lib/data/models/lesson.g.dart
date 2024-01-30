// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lesson.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Lesson _$LessonFromJson(Map<String, dynamic> json) => Lesson(
      id: json['id'] as String?,
      title: json['title'] as String?,
      content: json['content'] as String?,
      createdAt: dateTimeFromTimestamp(json['createdAt'] as Timestamp),
      updatedAt: dateTimeFromTimestamp(json['updatedAt'] as Timestamp),
    );

Map<String, dynamic> _$LessonToJson(Lesson instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('title', instance.title);
  writeNotNull('content', instance.content);
  writeNotNull('createdAt', dateTimeToTimestamp(instance.createdAt));
  writeNotNull('updatedAt', dateTimeToTimestamp(instance.updatedAt));
  return val;
}
