import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:quiz_app_new/bloc/questions/questions_bloc.dart';
import 'package:quiz_app_new/ui/widgets/login_form_text_field.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Choice extends StatelessWidget {
  final int choiceNumber;
  final int groupValue;
  final void Function(int?)? onChanged;
  final VoidCallback removeChoice;

  const Choice({
    super.key,
    required this.choiceNumber,
    required this.removeChoice,
    required this.groupValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final answers = context.read<QuestionsBloc>().answers;
    // TODO: add radio for correct answer
    return Stack(
      children: [
        Positioned(
          child: Card(
            child: Padding(
              padding: EdgeInsets.all(5.sp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("choice: ${choiceNumber + 1}"),
                  Gap(5.sp),
                  ListTile(
                    title: QuizTextField(
                      controller: answers[choiceNumber],
                      icon: Icons.title,
                      label: l10n.addChoice,
                      validator: (v) {
                        if (v != null && v.isEmpty) {
                          return "Must Enter Choice";
                        } else if (answers.asMap().entries.any((element) =>
                            element.key != choiceNumber &&
                            element.value.text == v)) {
                          return "Already $v is entered";
                        } else {
                          return null;
                        }
                      },
                    ),
                    trailing: Radio<int>(
                      value: choiceNumber,
                      groupValue: groupValue,
                      onChanged: onChanged,
                    ),
                  ),
                  Gap(5.sp),
                ],
              ),
            ),
          ),
        ),
        if (answers.length > 2)
          Positioned(
            right: 0,
            child: IconButton(
              onPressed: removeChoice,
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
