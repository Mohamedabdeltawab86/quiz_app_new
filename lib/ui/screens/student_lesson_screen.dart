import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:gap/gap.dart';
import 'package:quiz_app_new/bloc/lesson/lesson_bloc.dart';
import 'package:quiz_app_new/utils/routes.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../data/models/add_lesson_data_model.dart';
import '../../utils/routes.dart';

class StudentLessonScreen extends StatelessWidget {
  final String courseId;
  final String moduleId;
  final String lessonId;

  const StudentLessonScreen({
    super.key,
    required this.courseId,
    required this.moduleId,
    required this.lessonId,
  });

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<LessonBloc>();


    final l10n = AppLocalizations.of(context)!;
    // final loadLesson =
    //     LoadLesson(courseId: bloc., moduleId: moduleId, lessonId: lessonId);
    // final questionScreenArgs =
    //     QuestionScreenArguments(courseId, moduleId, lessonId, question);

    return Scaffold(
      appBar: AppBar(title: const Text("lessonTitle")),
      body: BlocConsumer<LessonBloc, LessonState>(
        listener: (context, state) {
          if (state is AnswersSubmitted){
            EasyLoading.show(status: "Your Score : ${state.score}", dismissOnTap: true);
          }
        },
        buildWhen: (previous, current) =>
            current is LessonLoaded ,
        builder: (context, lessonState) {
          if (lessonState is LessonLoaded) {
            final questions = lessonState.questions;
            return Stack(children: [
              SingleChildScrollView(
                child: Column(
                  children: List.generate(questions.length, (index) {
                    final question = questions[index];
                    final options = question.options;
                    return Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Card(
                        margin: EdgeInsets.symmetric(
                            horizontal: 8.sp, vertical: 4.sp),
                        child: BlocBuilder<LessonBloc, LessonState>(
                          buildWhen: (previous, current) =>
                              current is AnswersSubmitted,
                          builder: (context, state) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${index + 1}. ${question.title}",
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700),
                                ),
                                // const Gap(8),
                                ...options!.asMap().entries.map(
                                  (entry) {
                                    final index = entry.key;
                                    final option = entry.value;
                                    final isCorrectAnswer = state
                                            is AnswersSubmitted &&
                                        state.correctAnswers[question.id!]! ==
                                            true &&
                                        index == question.correctAnswer;
                                    final isWrongAnswer = state
                                            is AnswersSubmitted &&
                                        state.correctAnswers[question.id!]! ==
                                            false &&
                                        index == question.correctAnswer;
                                    return BlocBuilder<LessonBloc, LessonState>(
                                      buildWhen: (_, current) =>
                                          current is OptionSelectedState,
                                      builder: (context, state) {
                                        return RadioListTile(
                                          tileColor: isCorrectAnswer
                                              ? Colors.green
                                              : isWrongAnswer
                                              ? Colors.red
                                              : null,
                                          title: Text(
                                            option,

                                          ),
                                          value: index,
                                          groupValue:
                                              bloc.selectedOptions[question.id],
                                          onChanged: (value) {
                                            bloc.add(OptionSelected(
                                              questionId: question.id!,
                                              optionIndex: value!,
                                              questionIndex: index,
                                            ));
                                          },
                                        );
                                      },
                                    );
                                  },
                                ).toList(),
                              ],
                            );
                          },
                        ),
                      ),
                    );
                  }),
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: BlocConsumer<LessonBloc, LessonState>(
                  listener: (context, state) {
                    // if (state is AnswersSubmitted) {
                    //   EasyLoading.show(status: state.score.toString());
                    // }
                  },
                  builder: (context, state) {
                    return ElevatedButton(
                        onPressed: () {
                          bloc.isSubmitEnabled()
                              ? bloc.add(SubmitAnswers(questionList: questions, courseId:courseId, moduleId: moduleId, lessonId: lessonId ))
                              : null;

                          // bloc.add(SubmitAnswers(questionId: question.id!, optionIndex: optionIndex, questionList: questionList))
                        },
                        child: const Text("Submit Answers"));
                  },
                ),
              )
            ]);
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
