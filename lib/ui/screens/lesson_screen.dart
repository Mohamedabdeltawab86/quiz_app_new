import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app_new/bloc/course/course_bloc.dart';
import 'package:quiz_app_new/data/models/course.dart';

class LessonScreen extends StatelessWidget {
  final String courseId;
  final String moduleId;

  const LessonScreen({super.key, required this.courseId, required this.moduleId});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lessons'),
      ),
      body: BlocBuilder<CourseBloc, CourseState>(
        builder: (context, state) {
          if (state is LessonLoaded )
              // && state.moduleId == moduleId)
          {
            return ListView(
              children: state.lessons.map((lesson) => const ListTile(
                // title: Text(lesson.title!),
                title: Text("lesson.title!"),

              )).toList(),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
