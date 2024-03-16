// Done: 4. create a card that show the course details for the student.

import 'package:flutter/material.dart';

import '../../data/models/course.dart';

class StudentCourseCard extends StatelessWidget {
  final Course course;
  final VoidCallback onEnroll;
  final VoidCallback openCourse;
  final int cIndex;

  const StudentCourseCard(
      {super.key,
      required this.course,
      required this.onEnroll,
      required this.openCourse,
      required this.cIndex});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      child: ListTile(
        onTap: openCourse,
        leading:  CircleAvatar(
          child: Text("${cIndex+1}"),
        ),
        title: Text(course.title),
        subtitle: Text(course.id!),
      ),
    );
  }
}
