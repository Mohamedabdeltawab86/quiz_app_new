import 'package:flutter/material.dart';
import 'package:quiz_app_new/data/models/question.dart';

// TODO: added moduleId and lessonId to the loading module to be used later.
class LessonData {
  final String? lessonId;
  final TextEditingController lessonTitleController;
  final TextEditingController lessonContentController;

  LessonData({
    required this.lessonTitleController,
    required this.lessonContentController,
    this.lessonId,
  });
}

class ModuleData {
  final String? moduleId;
  final TextEditingController nameController;
  final List<LessonData> lessons;

  ModuleData({
    required this.nameController,
    required this.lessons,
    this.moduleId,
  });
}

class QuestionScreenArguments {
  final String courseId;
  final String moduleId;
  final String lessonId;
  final Question? question;

  QuestionScreenArguments(
      this.courseId, this.moduleId, this.lessonId, this.question);
}
