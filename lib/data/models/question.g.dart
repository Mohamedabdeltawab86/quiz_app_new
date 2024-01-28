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
      difficulty: $enumDecodeNullable(
              _$QuestionDifficultyEnumMap, json['difficulty']) ??
          QuestionDifficulty.normal,
      weight: json['weight'] as int?,
      type: $enumDecodeNullable(_$QuestionTypeEnumMap, json['type']) ??
          QuestionType.radio,
    );

Map<String, dynamic> _$QuestionToJson(Question instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'options': instance.options,
      'correctAnswer': instance.correctAnswer,
      'difficulty': _$QuestionDifficultyEnumMap[instance.difficulty]!,
      'weight': instance.weight,
      'type': _$QuestionTypeEnumMap[instance.type]!,
    };

const _$QuestionDifficultyEnumMap = {
  QuestionDifficulty.easy: 'easy',
  QuestionDifficulty.normal: 'normal',
  QuestionDifficulty.difficult: 'difficult',
};

const _$QuestionTypeEnumMap = {
  QuestionType.radio: 'radio',
  QuestionType.checkbox: 'checkbox',
  QuestionType.trueFalse: 'trueFalse',
  QuestionType.complete: 'complete',
};
