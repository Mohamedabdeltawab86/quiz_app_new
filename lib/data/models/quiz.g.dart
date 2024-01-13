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
      createdAt: Quiz._dateTimeFromTimestamp(json['createdAt'] as Timestamp),
      updatedAt: Quiz._dateTimeFromTimestamp(json['updatedAt'] as Timestamp),
      solvedAt: Quiz._dateTimeFromTimestamp(json['solvedAt'] as Timestamp),
      dueAt: Quiz._dateTimeFromTimestamp(json['dueAt'] as Timestamp),
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
      'createdAt': Quiz._dateTimeToTimestamp(instance.createdAt),
      'updatedAt': Quiz._dateTimeToTimestamp(instance.updatedAt),
      'solvedAt': Quiz._dateTimeToTimestamp(instance.solvedAt),
      'dueAt': Quiz._dateTimeToTimestamp(instance.dueAt),
    };
