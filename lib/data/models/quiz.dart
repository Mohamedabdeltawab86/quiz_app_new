import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
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
    fromJson: _dateTimeFromTimestamp,
    toJson: _dateTimeToTimestamp,
  )
  final  DateTime createdAt;
  @JsonKey(
    fromJson: _dateTimeFromTimestamp,
    toJson: _dateTimeToTimestamp,
  )
  final  DateTime updatedAt;
  @JsonKey(
    fromJson: _dateTimeFromTimestamp,
    toJson: _dateTimeToTimestamp,
  )
  final  DateTime solvedAt;

  @JsonKey(
    fromJson: _dateTimeFromTimestamp,
    toJson: _dateTimeToTimestamp,
  )
  final  DateTime dueAt;

  const Quiz({
    required this.id,
    required this.title,
    required this.questionsIds,
    required this.createdAt,
    required this.updatedAt,
    required this.solvedAt,
    required this.dueAt,

    this.difficulty,
    this.weight,
    this.averageTime,
  });

  factory Quiz.fromJson(Map<String, dynamic> json) => _$QuizFromJson(json);

  Map<String, dynamic> toJson() => _$QuizToJson(this);

  static DateTime _dateTimeFromTimestamp(Timestamp timestamp)=> timestamp.toDate();
  static Timestamp _dateTimeToTimestamp(DateTime dateTime)=> Timestamp.fromDate(dateTime);

  @override
  // DONE: you can check for id and updatedAt only, no need to check for everything.
  List<Object?> get props => [id, updatedAt, solvedAt];
}
