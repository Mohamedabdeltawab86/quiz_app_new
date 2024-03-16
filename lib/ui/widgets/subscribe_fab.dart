import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../bloc/enrolledCourses/enrolled_bloc.dart';
import 'login_form_text_field.dart';

class SubscribeFAB extends StatelessWidget {
  const SubscribeFAB({super.key});

  @override
  Widget build(BuildContext context) {
    final enrolledBloc = context.read<EnrolledBloc>();
    return FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return BlocProvider.value(
                value: enrolledBloc,
                child: AlertDialog(
                  title: const Text("Subscribe"),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      QuizTextField(
                        controller: enrolledBloc.codeController,
                        icon: Icons.subscriptions,
                        label: "Code",
                      ),
                      BlocBuilder<EnrolledBloc, EnrolledState>(
                        buildWhen: (previous, current) =>
                            current is IsPathValueChanged,
                        builder: (context, state) {
                          return CheckboxListTile(
                            value: enrolledBloc.isPath,
                            onChanged: (_) =>
                                enrolledBloc.add(ChangeIsPathValue()),
                            title: Text("Is This a Path?"),
                          );
                        },
                      )
                    ],
                  ),
                  actions: [
                    ElevatedButton(
                        onPressed: () => context.pop(),
                        child: const Text("Cancel")),
                    ElevatedButton(
                      child: const Text("Subscribe"),
                      onPressed: () {
                        final code = enrolledBloc.codeController.text;
                        if (code.isNotEmpty) {
                          enrolledBloc.add(SubscribeToCode(code));
                          context.pop();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content:
                                    Text("Subscribed to your teacher courses"),
                                duration: Duration(seconds: 4)),
                          );
                        } else {
                          context.pop();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content:
                                  Text("Please enter a valid teacher code."),
                              duration: Duration(seconds: 4),
                            ),
                          );
                        }
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
        child: const Icon(Icons.add));
  }
}
