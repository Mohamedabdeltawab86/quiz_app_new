import 'package:flutter/material.dart';
import 'package:quiz_app_new/data/models/question.dart';

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

class QuestionScreenArguments {
  final String courseId;
  final String moduleId;
  final String lessonId;
  final Question? question;

  QuestionScreenArguments(this.courseId, this.moduleId, this.lessonId, this.question);
}
