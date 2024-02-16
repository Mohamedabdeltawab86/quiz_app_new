import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../utils/common_functions.dart';

part 'question.g.dart';

enum QuestionType {
  @JsonValue("Radio")
  radio,
  @JsonValue("Checkbox")
  checkbox,
  @JsonValue("TrueFalse")
  trueFalse,
  @JsonValue("Complete")
  complete,
}

enum QuestionDifficulty {
  @JsonValue('Easy')
  easy,
  @JsonValue('Normal')
  normal,
  @JsonValue('Difficult')
  difficult,
}

@JsonSerializable(includeIfNull: false)
class Question extends Equatable {
  final String? id;
  final String? title;
  final List<String>? options;
  @JsonKey(name: "correct_answer")
  final int? correctAnswer;
  final QuestionDifficulty? difficulty;
  final int? weight;
  final QuestionType? type;
  @JsonKey(
    fromJson: dateTimeFromTimestamp,
    toJson: dateTimeToTimestamp,
    name: "updated_at",
  )
  final DateTime? updatedAt;

  const Question({
    this.id,
    this.title,
    this.options,
    this.correctAnswer,
    this.difficulty,
    this.weight,
    this.type,
    this.updatedAt,
  });

  factory Question.fromJson(Map<String, dynamic> json) =>
      _$QuestionFromJson(json);

  Map<String, dynamic> toJson() => _$QuestionToJson(this);

  @override
  List<Object?> get props => [id, updatedAt];
}
