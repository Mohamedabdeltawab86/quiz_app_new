// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Question _$QuestionFromJson(Map<String, dynamic> json) => Question(
      id: json['id'] as String?,
      title: json['title'] as String?,
      options:
          (json['options'] as List<dynamic>?)?.map((e) => e as String).toList(),
      correctAnswer: json['correctAnswer'] as String?,
      difficulty:
          $enumDecodeNullable(_$QuestionDifficultyEnumMap, json['difficulty']),
      weight: json['weight'] as int?,
      type: $enumDecodeNullable(_$QuestionTypeEnumMap, json['type']),
      updatedAt: dateTimeFromTimestamp(json['updatedAt'] as Timestamp),
    );

Map<String, dynamic> _$QuestionToJson(Question instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('title', instance.title);
  writeNotNull('options', instance.options);
  writeNotNull('correctAnswer', instance.correctAnswer);
  writeNotNull('difficulty', _$QuestionDifficultyEnumMap[instance.difficulty]);
  writeNotNull('weight', instance.weight);
  writeNotNull('type', _$QuestionTypeEnumMap[instance.type]);
  writeNotNull('updatedAt', dateTimeToTimestamp(instance.updatedAt));
  return val;
}

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
