import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../bloc/enrolledCourses/enrolled_bloc.dart';
import 'login_form_text_field.dart';

class SubscribeFAB extends StatelessWidget {
  final EnrolledBloc enrolledBloc;

  const SubscribeFAB({super.key, required this.enrolledBloc});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        onPressed: () => subScribeDialog(context, enrolledBloc),
        child: const Icon(Icons.add));
  }

  void subScribeDialog(context, EnrolledBloc enrolledBloc) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Subscribe to Teacher"),
          content: QuizTextField(
            controller: enrolledBloc.teacherCodeController,
            icon: Icons.subscriptions,
            label: "Teacher Code",
          ),
          actions: [
            ElevatedButton(
                onPressed: () => context.pop(), child: const Text("Cancel")),
            ElevatedButton(
                child: const Text("Subscribe"),
                onPressed: () {
                  final teacherId = enrolledBloc.teacherCodeController.text;
                  if (teacherId.isNotEmpty) {
                    enrolledBloc.add(SubscribeToTeacher(teacherId));
                    context.pop();
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Subscribed to your teacher courses"),
                        duration: Duration(seconds: 4)));
                  } else {
                    context.pop();
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Please enter a valid teacher code."),
                      duration: Duration(seconds: 4),
                    ));
                  }
                }),
          ],
        );
      },
    );
  }
}
