import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
part 'lesson.g.dart';

@JsonSerializable()
class Lesson extends Equatable{
  final int id;
  final String title;
  final String content;
  @JsonKey(
    fromJson: _dateTimeFromTimestamp,
    toJson: _dateTimeToTimestamp,
  )
  final DateTime createdAt;
  @JsonKey(
    fromJson: _dateTimeFromTimestamp,
    toJson: _dateTimeToTimestamp,
  )
  final DateTime updatedAt;

  const Lesson({
    required this.id,
    required this.title,
    required this.content,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Lesson.fromJson(Map<String, dynamic>json)=> _$LessonFromJson(json);

  Map<String, dynamic> toJson()=> _$LessonToJson(this);

  static DateTime _dateTimeFromTimestamp(Timestamp timestamp)=> timestamp.toDate();
  static Timestamp _dateTimeToTimestamp(DateTime dateTime)=> Timestamp.fromDate(dateTime);

  @override
  List<Object?> get props => [id, updatedAt];
}

