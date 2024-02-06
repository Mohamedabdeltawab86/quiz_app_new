import 'package:flutter/material.dart';

class LessonData {
  final TextEditingController lessonTitleController;
  final TextEditingController lessonContentController;

  LessonData({
    required this.lessonTitleController,
    required this.lessonContentController,
  });
}

class ModuleData {
  final TextEditingController nameController;
  final List<LessonData> lessons;

  ModuleData({required this.nameController, required this.lessons});
}
