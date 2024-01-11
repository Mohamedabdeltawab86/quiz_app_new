// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Question _$QuestionFromJson(Map<String, dynamic> json) => Question(
      title: json['title'] as String,
      options:
          (json['options'] as List<dynamic>).map((e) => e as String).toList(),
      correctAnswer: json['correctAnswer'] as String,
      difficulty: (json['difficulty'] as num?)?.toDouble(),
      weight: json['weight'] as int?,
      type: $enumDecodeNullable(_$QuestionTypeEnumMap, json['type']),
    );

Map<String, dynamic> _$QuestionToJson(Question instance) => <String, dynamic>{
      'title': instance.title,
      'options': instance.options,
      'correctAnswer': instance.correctAnswer,
      'difficulty': instance.difficulty,
      'weight': instance.weight,
      'type': _$QuestionTypeEnumMap[instance.type],
    };

const _$QuestionTypeEnumMap = {
  QuestionType.radio: 'radio',
  QuestionType.checkbox: 'checkbox',
  QuestionType.trueFalse: 'trueFalse',
  QuestionType.complete: 'complete',
};
