import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:quiz_app_new/ui/widgets/login_form_text_field.dart';

import '../../data/repositories/students_repo/students_repo.dart';
import '../widgets/home_widgets/drawer.dart';

class StudentsHome extends StatelessWidget {
  const StudentsHome({super.key});

  @override
  Widget build(BuildContext context) {
    final repo = context.read<StudentsRepo>();
    return Scaffold(
      appBar: AppBar(title: const Text("Home")),
      drawer: const HomeDrawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text("Course Enroll"),
                content: QuizTextField(
                  controller: TextEditingController(),
                  icon: Icons.attach_file,
                  label: "Course Code",
                ),
                actions: [
                  ElevatedButton(
                    onPressed: () async {
                      await repo.enrollCourse("ce060904b9c1").then((enrolled) {
                        context.pop();
                        if (enrolled) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Success!")),
                          );
                        }
                      });
                    },
                    child: Text("Add"),
                  ),
                ],
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
