import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:quiz_app_new/bloc/enrolledCourses/enrolled_bloc.dart';
import 'package:quiz_app_new/ui/widgets/student_course_card.dart';
import 'package:quiz_app_new/ui/widgets/subscribe_fab.dart';
import '../../utils/routes.dart';
import '../widgets/home_widgets/drawer.dart';

class StudentsHome extends StatelessWidget {
  const StudentsHome({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<EnrolledBloc>();
    return Scaffold(
      appBar: AppBar(title: const Text("My Courses")),
      body: BlocConsumer<EnrolledBloc, EnrolledState>(
        listener: (context, state) {
          if (state is SubscribeToCodeSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text("Successfully subscribed"),
              duration: Duration(seconds: 4),
            ));
          } else if (state is SubscribeToCodeError) {
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
        },
        buildWhen: (previous, current) =>
            current is EnrolledCourseFetched ||
            current is EnrolledCourseFetching,
        builder: (context, state) {
          if (state is EnrolledCourseFetching) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is EnrolledCourseFetched) {
            if (bloc.courses.isEmpty) {
              return const Center(child: Text("No enrolled courses"));
            }
            return ListView.builder(
              itemCount: bloc.courses.length,
              itemBuilder: (context, index) {
                final course = bloc.courses[index];
                return StudentCourseCard(
                  course: course,
                  openCourse: ()=> context.push(studentCourseDetail, extra: course),
                  onEnroll: () {
                    bloc.add(EnrollCourse(course.id!));
                  },
                  cIndex: index,
                );
              },
            );
          } else {
            return const Center(child: Text("No enrolled courses"));
          }
        },
      ),
      drawer: const HomeDrawer(),
      floatingActionButton: const SubscribeFAB(),
    );
  }
}
