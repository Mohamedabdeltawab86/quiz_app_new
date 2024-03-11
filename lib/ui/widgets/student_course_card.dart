// Done: 4. create a card that show the course details for the student.

import 'package:flutter/material.dart';

import '../../data/models/course.dart';

class StudentCourseCard extends StatelessWidget {
  final Course course;
  final VoidCallback onEnroll;
  final int cIndex;

  const StudentCourseCard(
      {super.key,
      required this.course,
      required this.onEnroll,
      required this.cIndex});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      child: ListTile(
        leading:  CircleAvatar(
          child: Text("${cIndex+1}"),
        ),
        title: Text(course.title),
        subtitle: Text(course.id!),
        trailing: IconButton(
          icon: Icon(
            course.isEnrolled ? Icons.check_circle : Icons.circle_outlined,
            color: course.isEnrolled ? Colors.green : Colors.grey,
          ),
          onPressed: course.isEnrolled ? null : onEnroll,
        ),
      ),
    );
  }
}
