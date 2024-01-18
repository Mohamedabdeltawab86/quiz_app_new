// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Question _$QuestionFromJson(Map<String, dynamic> json) => Question(
      id: json['id'] as String,
      title: json['title'] as String,
      options:
          (json['options'] as List<dynamic>).map((e) => e as String).toList(),
      correctAnswer: json['correctAnswer'] as String,
      difficulty: json['difficulty'] == null
          ? QuestionDifficulty.normal
          : Question.difficultyFromJson(json['difficulty']),
      weight: json['weight'] as int?,
      type: json['type'] == null
          ? QuestionType.radio
          : Question.questionTypeFromJson(json['type'] as String),
    );

Map<String, dynamic> _$QuestionToJson(Question instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'options': instance.options,
      'correctAnswer': instance.correctAnswer,
      'difficulty': Question.questionDiffToJson(instance.difficulty),
      'weight': instance.weight,
      'type': Question.questionTypeToJson(instance.type),
    };
