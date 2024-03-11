import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

import '../../utils/common_functions.dart';

part 'course.g.dart';

@JsonSerializable(includeIfNull: false)
class Course extends Equatable {
  final String? id;
  final String title;
  final String? description;
  final String? imageUrl;
  final String createdBy;
  @JsonKey(
    fromJson: dateTimeFromTimestamp,
    toJson: dateTimeToTimestamp,
  )
  final DateTime createdAt;
  @JsonKey(
    fromJson: dateTimeFromTimestamp,
    toJson: dateTimeToTimestamp,
  )
  final DateTime updatedAt;
  final bool isEnrolled;

  const Course({
    this.id,
    required this.title,
    this.description,
    this.imageUrl,
    this.createdBy = "Test",
    required this.createdAt,
    required this.updatedAt,
    this.isEnrolled = false,
  });

  factory Course.fromJson(Map<String, dynamic> json) => _$CourseFromJson(json);

  Map<String, dynamic> toJson() => _$CourseToJson(this);

  Course copyWith({
    String? id,
    String? title,
    String? description,
    String? createdBy,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isEnrolled,
  }) {
    return Course(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isEnrolled: isEnrolled ?? this.isEnrolled,
    );
  }

  @override
  List<Object?> get props => [id, updatedAt];
}
