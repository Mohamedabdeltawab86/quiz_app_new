import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app_new/bloc/enrolledCourses/enrolled_bloc.dart';
import 'package:quiz_app_new/ui/widgets/login_form_text_field.dart';
import '../widgets/home_widgets/drawer.dart';

class StudentsHome extends StatelessWidget {
  const StudentsHome({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<EnrolledBloc>();
    // Fetch enrolled courses as soon as the page is opened.
    bloc.add(FetchEnrolledCourses());

    return Scaffold(
      appBar: AppBar(title: const Text("My Courses")),
      body: BlocConsumer<EnrolledBloc, EnrolledState>(
        listener: (context, state) {
          if (state is EnrollMyTeacherCoursesAlreadySubscribed) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("You are already subscribed to this teacher."),
              ),
            );
          } else if (state is EnrollMyTeacherCoursesSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Successfully subscribed!")),
            );
            bloc.add(FetchEnrolledCourses()); // Fetch updated list of courses.
          } else if (state is EnrollMyTeacherCoursesError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          if (state is EnrolledCourseFetching) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is EnrolledCourseFetched && state.courses.isNotEmpty) {
            return ListView.builder(
              itemCount: state.courses.length,
              itemBuilder: (context, index) {
                final course = state.courses[index];
                return ListTile(
                  title: Text(course.title),
                  subtitle: Text("Course ID : ${course.id}"),
                );
              },
            );
          } else {
            return const Center(child: Text("No enrolled courses"));
          }
        },
      ),
      drawer: const HomeDrawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showSubscribeDialog(context, bloc),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showSubscribeDialog(BuildContext context, EnrolledBloc bloc) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Subscribe to Teacher"),
          content: QuizTextField(
            controller: bloc.teacherCodeController,
            icon: Icons.subscriptions,
            label: "Teacher Code",
          ),
          actions: [
            ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text("Cancel")),
            ElevatedButton(
              child: const Text("Subscribe"),
              onPressed: () {
                final teacherId = bloc.teacherCodeController.text;
                if (teacherId.isNotEmpty) {
                  bloc.add(SubscribeToTeacher(teacherId));
                  Navigator.of(context).pop();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Please enter a valid teacher code.")),
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }
}
