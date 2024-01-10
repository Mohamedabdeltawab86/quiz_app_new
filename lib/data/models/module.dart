import 'lesson.dart';

class Module {
  int id;
  String? title;
  List<Lesson?> lessons;
  DateTime createdAt;
  DateTime updatedAt;

  Module({
    required this.id,
    required this.title,
    required this.lessons,
    required this.createdAt,
    required this.updatedAt,
  });

  // Convert Module object to a map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'lessons': lessons.map((lesson) => lesson.toJson()).toList(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  // Create a Module object from a map
  factory Module.fromJson(Map<String, dynamic> json) {
    return Module(
      id: json['id'],
      title: json['title'],
      lessons: (json['lessons'] as List).map((lessonJson) => Lesson.fromJson(lessonJson)).toList(),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}
