import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:quiz_app_new/data/models/add_lesson_data_model.dart';
import 'package:sizer/sizer.dart';

import 'add_edit_lesson.dart';
import 'common_button.dart';
import 'login_form_text_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddEditModule extends StatelessWidget {
  const AddEditModule({
    super.key,
    required this.moduleNumber,
    required this.data,
    required this.removeModule,
    required this.addLesson,
    required this.removeLesson,
  });

  final ModuleData data;
  final int moduleNumber;
  final void Function() removeModule;
  final void Function() addLesson;
  final void Function(int) removeLesson;

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
                  Text("${l10n.module}: $moduleNumber"),
                  Gap(5.sp),
                  QuizTextField(
                    controller: data.nameController,
                    icon: Icons.tag,
                    label: l10n.moduleName,
                    validator: (_) => null,
                  ),
                  Gap(5.sp),
                  ListView.builder(
                    itemCount: data.lessons.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return AddEditLesson(
                        lessonNumber: index + 1,
                        data: data.lessons[index],
                        removeLesson: () => removeLesson(index),
                      );
                    },
                  ),
                  Gap(5.sp),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 50.w,
                        child: CommonButton(
                          onPressed: addLesson,
                          icon: Icons.add,
                          label: l10n.addLesson,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          right: 0,
          child: IconButton(
            onPressed: removeModule,
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
