import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:quiz_app_new/data/models/add_lesson_data_model.dart';
import 'package:quiz_app_new/ui/widgets/login_form_text_field.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddEditLesson extends StatelessWidget {
  const AddEditLesson({
    super.key,
    required this.lessonNumber,
    required this.data,
    required this.removeLesson,
  });

  final LessonData data;
  final int lessonNumber;
  final void Function() removeLesson;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Stack(
      children: [
        Positioned(
          child: Card(
            child: Padding(
              padding: EdgeInsets.all(5.sp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("${l10n.lesson}: $lessonNumber"),
                  Gap(5.sp),
                  QuizTextField(
                    controller: data.lessonTitleController,
                    icon: Icons.title,
                    label: l10n.lesson,
                    validator: (_) => null,
                  ),
                  Gap(5.sp),
                  QuizTextField(
                    controller: data.lessonContentController,
                    icon: Icons.text_snippet,
                    label: l10n.content,
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
