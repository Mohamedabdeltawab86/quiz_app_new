import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:quiz_app_new/bloc/course/course_bloc.dart';

import '../../data/models/module.dart';

class CoursePage extends StatelessWidget {
  const CoursePage({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<CourseBloc>();
    return Scaffold(
      appBar: AppBar(
        title: Text(bloc.course.title),
      ),
      body: BlocConsumer<CourseBloc, CourseState>(
          listener: (context, state) {
            if (state is ModulesLoading) {
              EasyLoading.show(status: "Loading..");
            } else {
              EasyLoading.dismiss();
            }
          },
          buildWhen: (_, current) => current is ModulesLoaded,
          builder: (context, state) {
            if (state is ModulesLoaded) {
              if (state.modules.isEmpty) {
                return const Center(child: Text("No Modules available"));
              }
              return ListView.builder(
                  itemCount: state.modules.length,
                  itemBuilder: (context, index) {
                    final Module module = state.modules[index];

                    return ExpansionTile(
                      leading:
                          const Icon(Icons.arrow_drop_down_circle_outlined),
                      title: Text(module.title ?? 'N/A'),
                      subtitle:
                          Text(DateFormat.MMMEd().format(module.updatedAt!)),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            // todo: edit course
                            onPressed: () {},
                            icon: const Icon(Icons.edit),
                          ),
                          IconButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title:
                                        const Text("Confirm deleting Module?"),
                                    actions: [
                                      TextButton(
                                        onPressed: () => context.pop(),
                                        child: const Text("Cancel"),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          bloc.add(
                                            DeleteModule(
                                              moduleID:
                                                  state.modules[index].id!,
                                            ),
                                          );
                                          context.pop();
                                        },
                                        child: const Text("OK"),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            icon: const Icon(Icons.delete),
                          ),
                        ],
                      ),
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
                                  return ListTile(
                                    title: Text(lesson.title!),
                                    onTap: () {
                                      final lessonId = state.lessons[index].id;
                                      context.push(
                                          '/courses/${bloc.course.id}/modules/${module.id}/lessons/$lessonId/lesson/${lesson.title}');
                                    },
                                  );
                                },

                              );
                            }
                            return const SizedBox();
                          },
                        ),
                      ],
                    );
                  });
            }
            return const SizedBox();
          }),
    );
  }
}
