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
      correctAnswer: json['correct_answer'] as int?,
      difficulty:
          $enumDecodeNullable(_$QuestionDifficultyEnumMap, json['difficulty']),
      weight: json['weight'] as int?,
      type: $enumDecodeNullable(_$QuestionTypeEnumMap, json['type']),
      feedback: json['feedback'] as String?,
      updatedAt: dateTimeFromTimestamp(json['updated_at'] as Timestamp),
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
  writeNotNull('correct_answer', instance.correctAnswer);
  writeNotNull('difficulty', _$QuestionDifficultyEnumMap[instance.difficulty]);
  writeNotNull('weight', instance.weight);
  writeNotNull('feedback', instance.feedback);
  writeNotNull('type', _$QuestionTypeEnumMap[instance.type]);
  writeNotNull('updated_at', dateTimeToTimestamp(instance.updatedAt));
  return val;
}

const _$QuestionDifficultyEnumMap = {
  QuestionDifficulty.easy: 'Easy',
  QuestionDifficulty.normal: 'Normal',
  QuestionDifficulty.difficult: 'Difficult',
};

const _$QuestionTypeEnumMap = {
  QuestionType.radio: 'Radio',
  QuestionType.checkbox: 'Checkbox',
  QuestionType.trueFalse: 'TrueFalse',
  QuestionType.complete: 'Complete',
};
