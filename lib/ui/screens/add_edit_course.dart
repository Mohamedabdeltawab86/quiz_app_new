import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:quiz_app_new/bloc/course/course_bloc.dart';
import 'package:quiz_app_new/ui/widgets/CommonTextField.dart';
import 'package:quiz_app_new/ui/widgets/common_button.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../common.dart';
import '../widgets/add_edit_lesson.dart';

class AddEditCourse extends StatelessWidget {
  const AddEditCourse({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<CourseBloc>();
    final l10n = AppLocalizations.of(context)!;
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: PopScope(
        canPop: true,
        onPopInvoked: (_) => bloc.clearCourseTextFields(),
        child: Padding(
          padding: EdgeInsets.all(8.0.sp),
          child: Scaffold(
            appBar: AppBar(
              title:
                  Text(bloc.course != null ? l10n.editCourse : "Add New Course"),
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
                      // TODO session 8-1: done
                      keyboardType: TextInputType.multiline,

                    ),
                    //   TODO 1 : Add image picker to let user change user profile and save it on firebase storage
                    const Divider(),
                    BlocBuilder<CourseBloc, CourseState>(
                      buildWhen: (previous, current) =>
                          current is LessonAdded || current is LessonDeleted,
                      builder: (context, state) {
                        return ListView.builder(
                          itemCount: bloc.lessonsData.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return AddEditLesson(
                              lessonNumber: index + 1,
                              data: bloc.lessonsData[index],
                              removeLesson: () => bloc.add(DeleteLesson(index)),
                            );
                          },
                        );
                      },
                    ),
                    Gap(8.sp),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 50.w,
                          child: CommonButton(
                            onPressed: () => bloc.add(AddLesson()),
                            icon: Icons.add,
                            label: "Add lesson",
                          ),
                        ),
                      ],
                    ),
                    const Divider(),
                    CommonButton(
                      onPressed: () => bloc.add(AddCourse()),
                      icon: Icons.add,
                      label: "add Course",
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
