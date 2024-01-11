import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'question.g.dart';

enum QuestionType { radio, checkbox, trueFalse, complete }

@JsonSerializable()
class Question extends Equatable {
  String title;
  List<String> options;
  String correctAnswer;
  double? difficulty; // Optional difficulty field
  int? weight; // Optional weight field
  // TODO: convert to String when sending to firestore and back when receiving.
  QuestionType? type; // Question type from the enum

  Question({
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

  @override
  List<Object?> get props =>
      [title, options, correctAnswer, difficulty, weight, type];
}
