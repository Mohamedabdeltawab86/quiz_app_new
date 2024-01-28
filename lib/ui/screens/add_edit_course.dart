import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';
import 'package:quiz_app_new/bloc/course/course_bloc.dart';
import 'package:quiz_app_new/ui/widgets/CommonTextField.dart';
import 'package:quiz_app_new/ui/widgets/common_button.dart';
import 'package:sizer/sizer.dart';

import '../common.dart';

class AddEditCourse extends StatelessWidget {
  const AddEditCourse({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<CourseBloc>();
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(bloc.course != null ? "Edit Course" : "Add New Course"),
        ),
        body: BlocListener<CourseBloc, CourseState>(
          listener: (context, state) async {
            if (state is AddingCourseLoading) {
              EasyLoading.show(status: 'Loading');
            } else if (state is AddingCourseDone) {
              EasyLoading.showSuccess("Done");
              context.pop();
            } else if (state is AddingCourseError) {
              EasyLoading.showError("ERROR!!");
            }
          },
          child: Form(
            key: bloc.courseKey,
            child: ListView(
              children: [
                //Todo: add image button
                CommonTextField(
                  label: "Title",
                  icon: Icons.abc,
                  controller: bloc.titleController,
                ),
                heightGap,
                CommonTextField(
                  label: "Description",
                  icon: Icons.text_fields,
                  controller: bloc.descriptionController,
                ),
              ],
            ),
          ),
        ),
        // TODO: add padding around
        bottomSheet: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: double.infinity,
            child: CommonButton(
              onPressed: () => bloc.add(AddCourse()),
              icon: Icons.add,
              label: "add",
            ),
          ),
        ),
      ),
    );
  }
}
