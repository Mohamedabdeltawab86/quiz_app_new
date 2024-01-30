import 'package:flutter/cupertino.dart';

class AddLessonDataModel {
  final TextEditingController lessonTitleController;
  final TextEditingController lessonContentController;


  AddLessonDataModel({
    required this.lessonTitleController,
    required this.lessonContentController,
  });
}
