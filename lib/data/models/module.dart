import 'package:cloud_firestore/cloud_firestore.dart';

import 'lesson.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
part 'module.g.dart';

@JsonSerializable()
class Module extends Equatable {
  final int id;
  final String? title;
  // Done: use IDs instead of whole objects, always remeber that you're using firestore not local db.
  final List<String> lessonIds;
  // DONE: convert those dates to Timestamps when converting toJson.
  // Done: convert them back to Datetime when receiveing from Json.
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

  const Module({
    required this.id,
    required this.title,
    required this.lessonIds,
    required this.createdAt,
    required this.updatedAt,
  });
  factory Module.fromJson(Map<String, dynamic> json) => _$ModuleFromJson(json);

  Map<String, dynamic> toJson() => _$ModuleToJson(this);
  static DateTime _dateTimeFromTimestamp(Timestamp timestamp) =>
      timestamp.toDate();

  static Timestamp _dateTimeToTimestamp(DateTime dateTime) =>
      Timestamp.fromDate(dateTime);
  @override
  List<Object?> get props => [id, title, lessonIds, createdAt, updatedAt];
}
