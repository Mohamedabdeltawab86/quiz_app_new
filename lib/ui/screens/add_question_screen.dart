import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:quiz_app_new/bloc/lesson/lesson_bloc.dart';
import 'package:quiz_app_new/ui/widgets/CommonTextField.dart';
import 'package:quiz_app_new/ui/widgets/common_button.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../bloc/courses/courses_bloc.dart';
import '../common.dart';
import '../widgets/add_edit_question.dart';

class AddEditQuestionScreen extends StatelessWidget {
  final String courseId;
  final String moduleId;
  final String lessonId;

  // final String questionTitle;

  const AddEditQuestionScreen({
    super.key,
    required this.courseId,
    required this.moduleId,
    required this.lessonId,
    // required this.questionTitle,
  });

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<LessonBloc>();
    final question = bloc.question;

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
                  bloc.question != null ? l10n.editCourse : l10n.addQuestion),
            ),
            body: Form(
              key: bloc.lessonKey,
              child: ListView(
                children: [
                  CommonTextField(
                    label: l10n.title,
                    icon: Icons.abc,
                    controller: bloc.titleController,
                    keyboardType: TextInputType.multiline,
                  ),
                  heightGap,
                  const Divider(),
                  BlocBuilder<LessonBloc, LessonState>(
                    buildWhen: (_, c) => c is ModuleDeleted || c is ModuleAdded,
                    builder: (context, state) {
                      return ListView.builder(
                        itemCount: bloc.addEditQuestionsData.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return AddEditQuestion(
                            questionNumber: index + 1,
                            data: bloc.addEditQuestionsData[index],
                            removeQuestion: () =>
                                bloc.add(DeleteQuestion(
                                    courseId: courseId,
                                    moduleId: moduleId,
                                    lessonId: lessonId,
                                    question: question!)),
                            addChoice: (cIndex) =>
                                bloc.add(AddChoice(
                                  questionIndex: index,
                                  ),),
                            removeChoice: (cIndex) =>
                                bloc.add(RemoveChoice(
                                    questionIndex: index, choiceIndex: cIndex)),
                          );
                        },
                      );
                    },
                  ),
                  Gap(8.sp),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 50.w,
                        child: CommonButton(
                          onPressed: () =>
                              bloc.add(
                                AddChoice(
                                  questionIndex: 1
                                       ),
                              ),
                          icon: Icons.add,
                          label: l10n.addModule,
                        ),
                      ),
                    ],
                  ),
                  const Divider(),
                  CommonButton(
                    onPressed: () =>
                        bloc.add(AddQuestion(
                            courseId: courseId,
                            moduleId: moduleId,
                            lessonId: lessonId,
                            question: question!)),
                    icon: Icons.add,
                    label: l10n.addQuestion,
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
