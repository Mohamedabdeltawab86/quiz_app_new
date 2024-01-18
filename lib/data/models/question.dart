import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'question.g.dart';

enum QuestionType { radio, checkbox, trueFalse, complete }

enum QuestionDifficulty { easy, normal, difficult }

@JsonSerializable()
class Question extends Equatable {
  final String id;
  final String title;
  final List<String> options;
  final String correctAnswer;
  @JsonKey(fromJson: difficultyFromJson, toJson: questionDiffToJson)
  final QuestionDifficulty difficulty;
  final int? weight;

  @JsonKey(fromJson: questionTypeFromJson, toJson: questionTypeToJson)
  final QuestionType type;

  const Question({
    required this.id,
    required this.title,
    required this.options,
    required this.correctAnswer,
    this.difficulty = QuestionDifficulty.normal,
    this.weight,
    this.type = QuestionType.radio,
  });

  factory Question.fromJson(Map<String, dynamic> json) =>
      _$QuestionFromJson(json);

  Map<String, dynamic> toJson() => _$QuestionToJson(this);

  static String questionTypeToJson(QuestionType type) => type.name;

  static String questionDiffToJson(QuestionDifficulty diff) => diff.name;

  static QuestionDifficulty difficultyFromJson(difficulty) {
    switch (difficulty) {
      case 'easy':
        return QuestionDifficulty.easy;
      case 'normal':
        return QuestionDifficulty.normal;
      case 'difficult':
        return QuestionDifficulty.difficult;
      default:
        return QuestionDifficulty.normal;
    }
  }

  static QuestionType questionTypeFromJson(String type) {
    switch (type) {
      case 'radio':
        return QuestionType.radio;
      case 'checkbox':
        return QuestionType.checkbox;
      case 'trueFalse':
        return QuestionType.trueFalse;
      case 'complete':
        return QuestionType.complete;
      default:
        return QuestionType.radio;
    }
  }

  @override
  List<Object?> get props => [id];
}
