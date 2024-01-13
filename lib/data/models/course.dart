import 'package:cloud_firestore/cloud_firestore.dart';

import 'module.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'course.g.dart';

@JsonSerializable()
class Course extends Equatable {
  final int id;
  final String? title;
  final String? description;
  final String? imageUrl;
  final int instructorId;
  final List<String> moduleIds;
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

  const Course({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.instructorId,
    required this.moduleIds,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Course.fromJson(Map<String, dynamic> json) => _$CourseFromJson(json);

  Map<String, dynamic> toJson() => _$CourseToJson(this);

  static DateTime _dateTimeFromTimestamp(Timestamp timestamp) =>
      timestamp.toDate();

  static Timestamp _dateTimeToTimestamp(DateTime dateTime) =>
      Timestamp.fromDate(dateTime);

  @override
  List<Object?> get props => [id, updatedAt];
}
