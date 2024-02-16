import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../bloc/lesson/lesson_bloc.dart';

class LessonScreen extends StatelessWidget {
  final String lessonTitle;

  const LessonScreen({super.key, required this.lessonTitle});


  @override
  Widget build(BuildContext context) {
    final bloc = context.read<LessonBloc>();
    final qStates = bloc.questionsState;
    return Scaffold(
      appBar: AppBar(title:  Text(lessonTitle)),
      body: BlocBuilder<LessonBloc, LessonState>(
        buildWhen: (previous, current) => current is LessonLoaded,
        builder: (context, lessonState) {
          if (lessonState is LessonLoaded) {
            final questions = lessonState.questions;
            return ListView.builder(
              itemCount: questions.length,
              itemBuilder: (context, i) {
                // todo: add edit & delete with slidable package
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 6.sp,
                        vertical: 15.sp,
                      ),
                      child: Text("${i + 1}"),
                    ),
                    Expanded(
                      child: ExpansionTile(
                        onExpansionChanged: (bool expanded) {
                          bloc.add(
                            ChangeQuestionState(
                              state: expanded,
                              index: i,
                            ),
                          );
                        },
                        tilePadding: EdgeInsets.symmetric(horizontal: 4.sp),
                        title: BlocBuilder<LessonBloc, LessonState>(
                          buildWhen: (_, c) =>
                              c is QuestionStateChanged && c.index == i,
                          builder: (context, state) {
                            return Text(
                              questions[i].title ?? "N/A",
                              maxLines: qStates[i] ? null : 1,
                              overflow:
                                  qStates[i] ? null : TextOverflow.ellipsis,
                            );
                          },
                        ),
                        expandedCrossAxisAlignment: CrossAxisAlignment.start,
                        // todo: check for language to edit alignment
                        expandedAlignment: Alignment.centerRight,
                        children: questions[i].options!.map(
                          (option) {
                            return Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 10.sp,
                                vertical: 5.sp,
                              ),
                              child: ListTile(
                                title: Text(option),
                                trailing: questions[i].correctAnswer ==
                                        questions[i].options!.indexOf(option)
                                    ? Icon(
                                        Icons.check,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .tertiary,
                                      )
                                    : const SizedBox(),
                              ),
                            );
                          },
                        ).toList(),
                      ),
                    ),
                  ],
                );
              },
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
