import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:quiz_app_new/data/models/add_lesson_data_model.dart';
import 'package:quiz_app_new/ui/widgets/add_edit_choice.dart';
import 'package:sizer/sizer.dart';
import 'common_button.dart';
import 'login_form_text_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddEditQuestion extends StatelessWidget {
  final QuestionData data;
  final int questionNumber;
  final void Function() removeQuestion;
  final void Function(int) addChoice;
  final void Function(int) removeChoice;

  const AddEditQuestion({
    super.key,
    required this.data,
    required this.questionNumber,
    required this.removeQuestion,
    required this.addChoice,
    required this.removeChoice,
  });

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
                  Text("${l10n.question}: $questionNumber"),
                  Gap(5.sp),
                  QuizTextField(
                    controller: data.nameController,
                    icon: Icons.tag,
                    label: l10n.questionName,
                    validator: (_) => null,
                  ),
                  Gap(5.sp),
                  ListView.builder(
                    itemCount: data.choices.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return AddEditChoice(
                        choiceNumber: index + 1,
                        removeChoice: ()=> removeChoice(index),
                        data: data.choices[index]
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
                          onPressed: ()=> addChoice,
                          icon: Icons.add,
                          label: l10n.addChoice,
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
            onPressed: removeQuestion,
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
