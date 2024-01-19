// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'module.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Module _$ModuleFromJson(Map<String, dynamic> json) => Module(
      id: json['id'] as int,
      title: json['title'] as String?,
      lessonIds:
          (json['lessonIds'] as List<dynamic>).map((e) => e as String).toList(),
      createdAt: dateTimeFromTimestamp(json['createdAt'] as Timestamp),
      updatedAt: dateTimeFromTimestamp(json['updatedAt'] as Timestamp),
    );

Map<String, dynamic> _$ModuleToJson(Module instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'lessonIds': instance.lessonIds,
      'createdAt': dateTimeToTimestamp(instance.createdAt),
      'updatedAt': dateTimeToTimestamp(instance.updatedAt),
    };
