import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'question.g.dart';

enum QuestionType {
  @JsonValue("radio")
  radio,
  @JsonValue("checkbox")
  checkbox,
  @JsonValue("trueFalse")
  trueFalse,
  @JsonValue("complete")
  complete,
}

enum QuestionDifficulty {
  @JsonValue('easy')
  easy,
  @JsonValue('normal')
  normal,
  @JsonValue('difficult')
  difficult,
}

@JsonSerializable()
class Question extends Equatable {
  final String id;
  final String title;
  final List<String> options;
  final String correctAnswer;
  final QuestionDifficulty difficulty;
  final int? weight;
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

  @override
  List<Object?> get props => [id];
}
