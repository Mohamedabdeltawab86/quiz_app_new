import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:quiz_app_new/data/models/add_lesson_data_model.dart';
import 'package:quiz_app_new/ui/widgets/login_form_text_field.dart';
import 'package:sizer/sizer.dart';

class AddEditLesson extends StatelessWidget {
  const AddEditLesson({
    super.key,
    required this.lessonNumber,
    required this.data,
    required this.removeLesson,
  });

  final AddLessonDataModel data;
  final int lessonNumber;
  final void Function() removeLesson;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          child: Card(
            child: Padding(
              padding: EdgeInsets.all(5.sp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Lesson: $lessonNumber"),
                  Gap(5.sp),
                  QuizTextField(
                    controller: data.lessonTitleController,
                    icon: Icons.title,
                    label: "title",
                    validator: (_) => null,
                  ),
                  Gap(5.sp),
                  QuizTextField(
                    controller: data.lessonContentController,
                    icon: Icons.text_snippet,
                    label: "content",
                    validator: (_) => null,
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          right: 0,
          child: IconButton(
            onPressed: removeLesson,
            icon: Icon(
              Icons.delete,
              color: Theme.of(context).colorScheme.error,
            ),
          ),
        ),
      ],
    );
  }
}
