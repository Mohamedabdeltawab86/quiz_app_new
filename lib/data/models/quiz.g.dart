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
      createdAt: dateTimeFromTimestamp(json['createdAt'] as Timestamp),
      updatedAt: dateTimeFromTimestamp(json['updatedAt'] as Timestamp),
      solvedAt: dateTimeFromTimestamp(json['solvedAt'] as Timestamp),
      score: json['score'] as int?,
      dueAt: dateTimeFromTimestamp(json['dueAt'] as Timestamp),
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
      'createdAt': dateTimeToTimestamp(instance.createdAt),
      'updatedAt': dateTimeToTimestamp(instance.updatedAt),
      'solvedAt': dateTimeToTimestamp(instance.solvedAt),
      'score': instance.score,
      'dueAt': dateTimeToTimestamp(instance.dueAt),
    };
