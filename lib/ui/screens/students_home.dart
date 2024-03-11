import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app_new/bloc/enrolledCourses/enrolled_bloc.dart';
import 'package:quiz_app_new/ui/widgets/student_course_card.dart';
import 'package:quiz_app_new/ui/widgets/subscribe_fab.dart';
import '../widgets/home_widgets/drawer.dart';

class StudentsHome extends StatelessWidget {
  const StudentsHome({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<EnrolledBloc>();

    bloc.add(FetchEnrolledCourses());

    return Scaffold(
      appBar: AppBar(title: const Text("My Courses")),
      body: BlocConsumer<EnrolledBloc, EnrolledState>(
        listener: (context, state) {
          if (state is SubscribeToTeacherAlreadySubscribed) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text("You are already subscribed to this teacher."),
              duration: Duration(seconds: 4),
            ));
          } else if (state is SubscribeToTeacherSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text("Successfully subscribed to teacher's courses!"),
              duration: Duration(seconds: 4),
            ));

            // bloc.add(FetchEnrolledCourses());
          } else if (state is SubscribeToTeacherError) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.message),
              duration: const Duration(seconds: 4),
            ));
          } else if (state is EnrolledCourseFetchingError) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.message),
              duration: const Duration(seconds: 4),
            ));
          }
          // else {
          //   ScaffoldMessenger.of(context).showSnackBar(
          //     const SnackBar(content: Text("No New Courses, check your teacher courses later... ")),
          //   );
          //   // bloc.add(FetchEnrolledCourses());
          // }
        },
        buildWhen: (previous, current) =>
            current is SubscribeToTeacherSuccess ||
            current is EnrolledCourseFetched ||
            current is EnrolledCourseFetching,
        builder: (context, state) {
          if (state is EnrolledCourseFetching) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is EnrolledCourseFetched &&
              state.courses.isNotEmpty) {
            return ListView.builder(
              itemCount: state.courses.length,
              itemBuilder: (context, index) {
                final course = state.courses[index];
                return StudentCourseCard(
                    course: course,
                    onEnroll: () {
                      if (!course.isEnrolled) {
                        bloc.add(EnrollCourse(course.id!));
                      }
                    },
                    cIndex: index);
              },
            );
          } else {
            return const Center(child: Text("No enrolled courses"));
          }
        },
      ),
      drawer: const HomeDrawer(),
      floatingActionButton: SubscribeFAB(enrolledBloc: bloc),
    );
  }
}
