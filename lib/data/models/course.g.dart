// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Course _$CourseFromJson(Map<String, dynamic> json) => Course(
      id: json['id'] as String?,
      title: json['title'] as String,
      description: json['description'] as String?,
      imageUrl: json['imageUrl'] as String?,
      createdBy: json['createdBy'] as String? ?? "Test",
      createdAt: dateTimeFromTimestamp(json['createdAt'] as Timestamp),
      updatedAt: dateTimeFromTimestamp(json['updatedAt'] as Timestamp),
    );

Map<String, dynamic> _$CourseToJson(Course instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  val['title'] = instance.title;
  writeNotNull('description', instance.description);
  writeNotNull('imageUrl', instance.imageUrl);
  val['createdBy'] = instance.createdBy;
  writeNotNull('createdAt', dateTimeToTimestamp(instance.createdAt));
  writeNotNull('updatedAt', dateTimeToTimestamp(instance.updatedAt));
  return val;
}
