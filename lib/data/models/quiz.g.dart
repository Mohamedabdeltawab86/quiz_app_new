// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quiz.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Quiz _$QuizFromJson(Map<String, dynamic> json) => Quiz(
      id: json['id'] as int,
      title: json['title'] as String,
      questionsIds: (json['questionsIds'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      difficulty: (json['difficulty'] as num?)?.toDouble(),
      weight: json['weight'] as int?,
      averageTime: json['averageTime'] as int?,
    );

Map<String, dynamic> _$QuizToJson(Quiz instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'questionsIds': instance.questionsIds,
      'difficulty': instance.difficulty,
      'weight': instance.weight,
      'averageTime': instance.averageTime,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };
