import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:go_router/go_router.dart';
import 'package:quiz_app_new/data/models/add_lesson_data_model.dart';
import 'package:quiz_app_new/utils/routes.dart';
import 'package:sizer/sizer.dart';

import '../../bloc/lesson/lesson_bloc.dart';
import '../../bloc/questions/questions_bloc.dart';

class LessonScreen extends StatelessWidget {
  final String courseId;
  final String moduleId;
  final String lessonId;
  final String lessonTitle;

  const LessonScreen({super.key,
    required this.courseId,
    required this.moduleId,
    required this.lessonId,
    required this.lessonTitle});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<LessonBloc>();
    final qStates = bloc.questionsState;
    final question = bloc.question;
    return Scaffold(
      appBar: AppBar(title: Text(lessonTitle)),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          context.push(
            // '/courses/$courseId/modules/$moduleId/lessons/$lessonId/addEditQuestion',
              addEditQuestion,
              extra: QuestionScreenArguments(courseId, moduleId, lessonId));
        },
      ),
      body: BlocConsumer<LessonBloc, LessonState>(
        listener: (context, state) {
          // if (state is QuestionDeleted) {
          //   bloc.add(LoadLesson(
          //       courseId: courseId, moduleId: moduleId, lessonId: lessonId));
          // }
        },
        buildWhen: (previous, current) =>
        current is LessonLoaded ,
        builder: (context, lessonState) {
          if (lessonState is LessonLoaded) {
            final questions = lessonState.questions;
            final lessons = lessonState.lessons;
            return ListView.builder(
              itemCount: questions.length,
              itemBuilder: (context, i) {
                final question = questions[i];
                // todo: add edit & delete with slidable package
                return Slidable(
                  // key: ValueKey(lessons[i].id),
                  endActionPane: ActionPane(
                    motion: const ScrollMotion(),
                    children: [
                      BlocBuilder<QuestionsBloc, QuestionsState>(
                        builder: (context, state) {
                          final bloc2 = context.read<QuestionsBloc>();
                          return SlidableAction(
                            label: 'Delete',
                            backgroundColor: Colors.amber,
                            icon: Icons.delete,
                            spacing: 8,
                            onPressed: (context) =>
                                bloc2.add(DeleteQuestion(
                                  question.id!
                                  // question: questions[i],
                                )),
                          );
                        },
                      ),
                      SlidableAction(
                        label: 'Edit',
                        backgroundColor: Colors.amber,
                        icon: Icons.edit,
                        spacing: 8,
                        onPressed: (context) {
                          // bloc.selectedCourse;

                          showDialog(
                            context: context,
                            builder: (context) {
                              return SizedBox(
                                height: 600,
                                child: AlertDialog(
                                  title: const Text("Edit Course title"),
                                  content: const Column(
                                    children: [
                                      TextField(
                                        // controller: bloc.titleController,
                                      ),
                                      TextField(
                                        // controller:
                                        // bloc.descriptionController,
                                      ),
                                    ],
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () => context.pop(),
                                      child: const Text("Cancel"),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        // bloc.add(
                                        // UpdateLessonCourse(selectedCourse.id!),
                                        // );
                                        context.pop();
                                      },
                                      child: const Text("OK"),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),

                  child: Row(
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
                        child:
                        // Slidable(
                        //   // key: ValueKey(lessons[i].id),
                        //   endActionPane: ActionPane(
                        //     motion: const ScrollMotion(),
                        //     children: [
                        //     SlidableAction(
                        //     label: 'Delete',
                        //     backgroundColor: Colors.amber,
                        //     icon: Icons.delete,
                        //     spacing: 8,
                        //     onPressed: (context) => bloc.add(DeleteLesson(courseId: courseId, moduleId: moduleId, lessonId: lessonId)),
                        //   ),
                        //   ],
                        //   ),
                        //   child:
                        ExpansionTile(
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
                                    color: Theme
                                        .of(context)
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
                      // ),
                    ],
                  ),
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
