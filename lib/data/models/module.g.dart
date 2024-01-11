// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'module.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Module _$ModuleFromJson(Map<String, dynamic> json) => Module(
      id: json['id'] as int,
      title: json['title'] as String?,
      lessons: (json['lessons'] as List<dynamic>)
          .map((e) =>
              e == null ? null : Lesson.fromJson(e as Map<String, dynamic>))
          .toList(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$ModuleToJson(Module instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'lessons': instance.lessons,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };
