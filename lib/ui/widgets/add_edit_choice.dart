import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:quiz_app_new/data/models/add_lesson_data_model.dart';
import 'package:quiz_app_new/ui/widgets/login_form_text_field.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddEditChoice extends StatelessWidget {
  final ChoiceData data;
  final int choiceNumber;
  final void Function() removeChoice;

  const AddEditChoice({
    super.key,
    required this.data,
    required this.choiceNumber,
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
                  Text("${l10n.lesson}: $choiceNumber"),
                  Gap(5.sp),
                  QuizTextField(
                    controller: data.choiceController,
                    icon: Icons.title,
                    label: l10n.lesson,
                    validator: (_) => null,
                  ),
                  Gap(5.sp),
                ],
              ),
            ),
          ),
        ),
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
