import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

import '../../utils/common_functions.dart';
part 'quiz.g.dart';

@JsonSerializable()
class Quiz extends Equatable {
  final int id;
  final String title;
  final List<String> questionsIds;
  final double? difficulty;
  final int? weight;
  final int? averageTime;
  @JsonKey(
    fromJson: dateTimeFromTimestamp,
    toJson: dateTimeToTimestamp,
  )
  final  DateTime createdAt;
  @JsonKey(
    fromJson: dateTimeFromTimestamp,
    toJson: dateTimeToTimestamp,
  )
  final  DateTime updatedAt;
  @JsonKey(
    fromJson: dateTimeFromTimestamp,
    toJson: dateTimeToTimestamp,
  )
  final  DateTime solvedAt;
  final int? score;

  @JsonKey(
    fromJson: dateTimeFromTimestamp,
    toJson: dateTimeToTimestamp,
  )
  final  DateTime dueAt;

  const Quiz({
    required this.id,
    required this.title,
    required this.questionsIds,
    required this.createdAt,
    required this.updatedAt,
    required this.solvedAt,
    this.score,
    required this.dueAt,

    this.difficulty,
    this.weight,
    this.averageTime,
  });

  factory Quiz.fromJson(Map<String, dynamic> json) => _$QuizFromJson(json);

  Map<String, dynamic> toJson() => _$QuizToJson(this);


  @override
  List<Object?> get props => [id, updatedAt, solvedAt];
}
