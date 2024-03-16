import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../bloc/course/course_bloc.dart';
import '../../data/models/add_lesson_data_model.dart';
import '../../data/models/module.dart';

class StudentCourseDetailsScreen extends StatelessWidget {
  const StudentCourseDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<CourseBloc>();

    return Scaffold(
        appBar: AppBar(title: Text(bloc.course.title)),
        body: BlocConsumer<CourseBloc, CourseState>(
          listener: (context, state) {
            if (state is ModulesLoading) {
              EasyLoading.show(status: "Loading");
            } else {
              EasyLoading.dismiss();
            }
          },
          buildWhen: (previous, current) => current is ModulesLoaded,
          builder: (context, state) {
            if (state is ModulesLoaded) {
              if (state.modules.isEmpty) {
                return const Center(
                  child: Text("No Modules avaiable"),
                );
              }
              return ListView.builder(
                itemCount: state.modules.length,
                itemBuilder: (context, index) {
                  final Module module = state.modules[index];

                  return ExpansionTile(
                    leading: const Icon(Icons.arrow_drop_down_circle_sharp),
                    title: Text(module.title!),
                    subtitle:
                        Text(DateFormat.MMMEd().format(module.createdAt!)),
                    onExpansionChanged: (bool expanded) {
                      if (expanded) {
                        bloc.add(LoadLessons(module.id!));
                      }
                    },
                    children: [
                      BlocBuilder<CourseBloc, CourseState>(
                        builder: (context, state) {
                          if (state is LessonLoaded) {
                            return ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: state.lessons.length,
                              itemBuilder: (context, index) {
                                final lesson = state.lessons[index];
                                // TODO how to pass question here, I do not have it.
                                // final questionScreenArgs =
                                // QuestionScreenArguments(bloc.course.id!,  module.id!, lesson.id!, question);
                                print("current Lesson is $lesson");
                                return ListTile(
                                  title: Text(lesson.title!),
                                  onTap: () {

                                    context.push(
                                        '/courses/${bloc.course.id}/modules/${module.id}/lessons/${lesson.id}');
                                  },
                                );
                              },
                            );
                          }
                          return const SizedBox();
                        },
                      )
                    ],
                  );
                },
              );
            }
            return const SizedBox();
          },
        ));
  }
}
