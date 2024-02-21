import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:go_router/go_router.dart';

import 'package:quiz_app_new/bloc/questions/questions_bloc.dart';
import 'package:quiz_app_new/ui/widgets/choice.dart';

import 'package:sizer/sizer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../common.dart';
import '../widgets/CommonTextField.dart';

import '../widgets/common_button.dart';

class AddEditQuestionScreen extends StatelessWidget {
  const AddEditQuestionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<QuestionsBloc>();
    // final question = bloc.question;

    final l10n = AppLocalizations.of(context)!;
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: PopScope(
        canPop: false,
        onPopInvoked: (bool didPop) {
          if (!didPop && bloc.state is! QuestionAdded) {
            // bloc.clearCourseTextFields();
          }
          context.pop();
        },
        child: Padding(
          padding: EdgeInsets.all(8.0.sp),
          child: Scaffold(
            appBar: AppBar(
              title: Text(
                bloc.question != null ? l10n.editCourse : l10n.addQuestion,
              ),
            ),
            body: Form(
              key: bloc.questionKey,
              child: ListView(
                children: [
                  CommonTextField(
                    label: l10n.title,
                    icon: Icons.abc,
                    controller: bloc.titleController,
                    validator: (v) {
                      if (v != null && v.isEmpty) {
                        return "Must Enter Question";
                      } else {
                        return null;
                      }
                    },
                  ),
                  heightGap,
                  BlocBuilder<QuestionsBloc, QuestionsState>(
                    buildWhen: (_, current) =>
                        current is ChoiceAdded ||
                        current is CorrectAnswerChanged ||
                        current is ChoiceDeleted,
                    builder: (context, state) {
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: bloc.answers.length,
                        itemBuilder: (context, index) {
                          return Choice(
                            choiceNumber: index,
                            removeChoice: () => bloc.add(RemoveChoice(index)),
                            groupValue: bloc.correctAnswerIndex,
                            onChanged: (_) => bloc.add(SetCorrectAnswer(index)),
                          );
                        },
                      );
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 50.w,
                        child: CommonButton(
                          onPressed: () => bloc.add(AddChoice()),
                          icon: Icons.add,
                          label: l10n.addChoice,
                        ),
                      ),
                    ],
                  ),
                  const Divider(),
                  BlocListener<QuestionsBloc, QuestionsState>(
                    listener: (context, state) {
                      // TODO: implement listener
                      if (state is QuestionAdded) {
                        context.pop();
                      } else if (state is QuestionError) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: const Center(child: Text("ERROR")),
                            backgroundColor:
                                Theme.of(context).colorScheme.error,
                          ),
                        );
                      }
                    },
                    child: CommonButton(
                      onPressed: () {
                        bloc.add(AddQuestion());
                      },
                      icon: Icons.add,
                      label: l10n.addQuestion,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
