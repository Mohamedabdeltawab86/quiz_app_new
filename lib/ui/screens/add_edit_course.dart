import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:quiz_app_new/ui/widgets/CommonTextField.dart';
import 'package:quiz_app_new/ui/widgets/add_edit_module.dart';
import 'package:quiz_app_new/ui/widgets/common_button.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../bloc/courses/courses_bloc.dart';
import '../common.dart';

class AddEditCourse extends StatelessWidget {
  const AddEditCourse({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<CoursesBloc>();
    final l10n = AppLocalizations.of(context)!;
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: PopScope(
        // TODO: fix by ibrahim
        canPop: true,
        onPopInvoked: (_) => bloc.clearCourseTextFields(),
        child: Padding(
          padding: EdgeInsets.all(8.0.sp),
          child: Scaffold(
            appBar: AppBar(
              title: Text(
                  bloc.course != null ? l10n.editCourse : l10n.addNewCourse),
            ),
            body: BlocListener<CoursesBloc, CoursesState>(
              listener: (context, state) async {
                if (state is AddingCourseLoading) {
                  EasyLoading.show(status: 'Loading');
                } else if (state is AddingCourseDone) {
                  EasyLoading.showSuccess("Done");
                  context.pop();
                  bloc.clearCourseTextFields();
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
                      label: l10n.title,
                      icon: Icons.abc,
                      controller: bloc.titleController,
                    ),
                    heightGap,
                    CommonTextField(
                      label: l10n.description,
                      icon: Icons.text_fields,
                      controller: bloc.descriptionController,
                      // TODO session 8-1: done
                      keyboardType: TextInputType.multiline,
                    ),
                    //   TODO 1 : Add image picker to let user change user profile and save it on firebase storage
                    const Divider(),
                    BlocBuilder<CoursesBloc, CoursesState>(
                      buildWhen: (_, c) =>
                          c is LessonAdded ||
                          c is LessonDeleted ||
                          c is ModuleDeleted ||
                          c is ModuleAdded,
                      builder: (context, state) {
                        return ListView.builder(
                          itemCount: bloc.addEditModulesData.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, mIndex) {
                            return AddEditModule(
                              moduleNumber: mIndex + 1,
                              data: bloc.addEditModulesData[mIndex],
                              removeModule: () =>
                                  bloc.add(DeleteModule(mIndex)),
                              removeLesson: (lIndex) => bloc.add(
                                DeleteLesson(
                                  moduleIndex: mIndex,
                                  lessonIndex: lIndex,
                                ),
                              ),
                              addLesson: () => bloc.add(AddLesson(mIndex)),
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
                            onPressed: () => bloc.add(AddModule()),
                            icon: Icons.add,
                            label: l10n.addModule,
                          ),
                        ),
                      ],
                    ),
                    const Divider(),
                    CommonButton(
                      onPressed: () => bloc.add(AddCourse()),
                      icon: Icons.add,
                      label: l10n.addNewCourse,
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
