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



class QuestionData {
  final TextEditingController nameController;
  final List<ChoiceData> choices;

  QuestionData({
    required this.nameController,
    required this.choices,
  });
}

class ChoiceData {
  final TextEditingController choiceController;

  ChoiceData({required this.choiceController});
}
