import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:quiz_app_new/bloc/lesson/lesson_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../data/models/lesson.dart';

class StudentLessonScreen extends StatelessWidget {
  final String courseId;
  final String moduleId;
  final String lessonId;
  // final String lessonTitle;
  // final String lessonContent;

  const StudentLessonScreen({
    super.key,
    required this.courseId,
    required this.moduleId,
    required this.lessonId,
    // required this.lessonTitle,
    // required this.lessonContent,

  });

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<LessonBloc>();
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title:  Text("lessonTitle")),
      body: BlocConsumer<LessonBloc, LessonState>(
        listener: (context, state) {
          if (state is AnswersSubmitted) {
            EasyLoading.show(status: "Your Score : ${state.score}", dismissOnTap: true);
          }
        },
        buildWhen: (previous, current) => current is LessonLoaded,
        builder: (context, lessonState) {
          if (lessonState is LessonLoaded) {
            final questions = lessonState.questions;
            final previousAnswers = lessonState.previousAnswers;
            return Column(
                children: [
                  Card(
                    margin:
                        EdgeInsets.symmetric(horizontal: 8.sp, vertical: 4.sp),
                    child: BlocBuilder<LessonBloc, LessonState>(
                      buildWhen: (previous, current) =>
                          current is AnswersSubmitted,
                      builder: (context, state) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                              Text(
                              "lessonContent",
                              style:  const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            BlocBuilder<LessonBloc, LessonState>(
                              buildWhen: (_, current) =>
                                  current is OptionSelectedState,
                              builder: (context, state) {
                                return RadioListTile(
                                  tileColor: null,
                                  title: const Text("title"),
                                  value: 0,
                                  groupValue: null,
                                  onChanged: (value) {},
                                );
                              },
                            )
                          ],
                        );
                      },
                    ),
                  ),
                ],
              );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
