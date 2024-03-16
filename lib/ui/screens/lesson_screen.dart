import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:go_router/go_router.dart';
import 'package:quiz_app_new/data/models/add_lesson_data_model.dart';
import 'package:quiz_app_new/utils/routes.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../bloc/lesson/lesson_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class LessonScreen extends StatelessWidget {
  final String courseId;
  final String moduleId;
  final String lessonId;
  final String lessonTitle;

  const LessonScreen(
      {super.key,
      required this.courseId,
      required this.moduleId,
      required this.lessonId,
      required this.lessonTitle});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<LessonBloc>();
    final qStates = bloc.questionsState;
    final question = bloc.question;
    final l10n = AppLocalizations.of(context)!;
    final loadLesson =
        LoadLesson(courseId: courseId, moduleId: moduleId, lessonId: lessonId);
    final questionScreenArgs =
        QuestionScreenArguments(courseId, moduleId, lessonId, question);
    return Scaffold(
      appBar: AppBar(title: Text(lessonTitle)),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          // TODO: see how i'm waiting for the value from the next page.
          var questionAdded =
              await context.push(addEditQuestion, extra: questionScreenArgs);
          if (questionAdded is bool && questionAdded) {
            bloc.add(loadLesson);
          }
        },
      ),
      body: BlocConsumer<LessonBloc, LessonState>(
        listener: (context, state) {
          if (state is QuestionAdded) {
            bloc.add(loadLesson);
            EasyLoading.showSuccess(l10n.questionAdded);
          } else if (state is QuestionDeleted) {
            bloc.add(loadLesson);
            EasyLoading.showSuccess(l10n.questionDeleted);
          }
        },
        buildWhen: (previous, current) =>
            current is LessonLoaded ||
            current is QuestionAdded ||
            current is QuestionDeleted,
        builder: (context, lessonState) {
          if (lessonState is LessonLoaded) {
            final questions = lessonState.questions;
            return ListView.builder(
              itemCount: questions.length,
              itemBuilder: (context, i) {
                final question = questions[i];

                return Slidable(
                  endActionPane: ActionPane(
                    motion: const ScrollMotion(),
                    children: [
                      BlocBuilder<LessonBloc, LessonState>(
                        builder: (context, state) {
                          return SlidableAction(
                            label: l10n.delete,
                            backgroundColor: Colors.amber,
                            icon: Icons.delete,
                            spacing: 8,
                            onPressed: (context) => bloc.add(DeleteQuestion(
                                courseId: courseId,
                                moduleId: moduleId,
                                lessonId: lessonId,
                                question: question)),
                          );
                        },
                      ),
                      SlidableAction(
                        label: l10n.edit,
                        backgroundColor: Colors.amber,
                        icon: Icons.edit,
                        spacing: 8,
                        onPressed: (context) {
                          context.push(
                            addEditQuestion,
                            extra: questionScreenArgs,
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
                      
                            ExpansionTile(
                          onExpansionChanged: (bool expanded) => bloc.add(
                            ChangeQuestionState(state: expanded, index: i),
                          ),
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
