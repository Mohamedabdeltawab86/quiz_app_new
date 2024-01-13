import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'question.g.dart';

enum QuestionType { radio, checkbox, trueFalse, complete }

@JsonSerializable()
class Question extends Equatable {
  final String id;
  final String title;
  final List<String> options;
  final String correctAnswer;
  final double? difficulty;
  final int? weight;

  // Done: convert to String when sending to firestore and back when receiving.
  @JsonKey(
    fromJson: questionTypeFromJson,
    toJson: questionTypeToJson,
  )
  final QuestionType? type;

  const Question({
    required this.id,
    required this.title,
    required this.options,
    required this.correctAnswer,
    this.difficulty,
    this.weight,
    this.type,
  });

  factory Question.fromJson(Map<String, dynamic> json) =>
      _$QuestionFromJson(json);

  Map<String, dynamic> toJson() => _$QuestionToJson(this);

  static String questionTypeToJson(QuestionType? type) {
    return type?.toString() ?? '';
  }

  static QuestionType? questionTypeFromJson(String type) {
    switch (type) {
      case 'QuestionType.radio':
        return QuestionType.radio;
      case 'QuestionType.checkbox':
        return QuestionType.checkbox;
      case 'QuestionType.trueFalse':
        return QuestionType.trueFalse;
      case 'QuestionType.complete':
        return QuestionType.complete;
      default:
        return null;
    }
  }

  @override
  List<Object?> get props => [id];
}
