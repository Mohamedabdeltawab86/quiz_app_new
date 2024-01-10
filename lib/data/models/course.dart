import 'module.dart';

class Course {
  int id;
  String? title;
  String? description;
  String? image;
  int instructorId;
  List<Module?> modules;
  DateTime createdAt;
  DateTime updatedAt;

  Course({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
    required this.instructorId,
    required this.modules,
    required this.createdAt,
    required this.updatedAt,
  });

  // Convert Subject object to a map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'image': image,
      'instructorId': instructorId,
      'modules': modules.map((module) => module.toJson()).toList(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  // Create a Subject object from a map
  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      image: json['image'],
      instructorId: json['instructorId'],
      modules: (json['modules'] as List).map((moduleJson) => Module.fromJson(moduleJson)).toList(),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}
