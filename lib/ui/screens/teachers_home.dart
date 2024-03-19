import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:quiz_app_new/utils/common_functions.dart';

import 'package:quiz_app_new/utils/routes.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:sizer/sizer.dart';

import '../../bloc/courses/courses_bloc.dart';
import '../widgets/home_widgets/drawer.dart';
import 'package:share_plus/share_plus.dart';

class TeachersHome extends StatelessWidget {
  const TeachersHome({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final bloc = context.read<CoursesBloc>();
    return Padding(
      padding: EdgeInsets.all(8.0.sp),
      child: Scaffold(
        drawer: const HomeDrawer(),
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.courses),
        ),
        body: BlocConsumer<CoursesBloc, CoursesState>(
          listener: (context, state) {
            if (state is CourseFetching) {
              EasyLoading.show(status: l10n.loading);
            } else if (state is AddingCourseDone) {
              bloc.add(FetchCourses());
            } else if (state is DeletingCourseSuccess) {
              bloc.add(FetchCourses());
            } else if (state is UpdatingCourseSuccess) {
              bloc.add(FetchCourses());
            } else if (state is CoursesDuplicationSuccess) {
              bloc.add(FetchCourses());
            } else {
              EasyLoading.dismiss();
            }
          },
          buildWhen: (previous, current) =>
              current is CourseFetched || current is CoursesDuplicationSuccess,
          builder: (context, state) {
            if (bloc.courses.isNotEmpty) {
              return RefreshIndicator(
                onRefresh: () async => bloc.add(FetchCourses()),
                child: ListView.builder(
                  itemCount: bloc.courses.length,
                  itemBuilder: (context, index) {
                    final selectedCourse = bloc.courses[index];
                    return Card(
                      child: Slidable(
                        endActionPane: ActionPane(
                          motion: const ScrollMotion(),
                          children: [
                            SlidableAction(
                              label: "Copy Course",
                              // backgroundColor: Colors.amber,
                              icon: Icons.copy,
                              // spacing: 8,
                              onPressed: (_) {
                                context.read<CoursesBloc>().add(
                                    DuplicateCourse(bloc.courses[index].id!));
                              },
                            ),
                            SlidableAction(
                              label: "share",
                              // backgroundColor: Colors.blue,
                              icon: Icons.share,
                              // spacing: 8,
                              onPressed: (_) {
                                Share.share(
                                    '${l10n.shareCourse} ${selectedCourse.title} ${selectedCourse.id}');
                              },
                            ),
                            SlidableAction(
                              label: l10n.delete,
                              // backgroundColor: Colors.amber,
                              icon: Icons.delete,
                              // spacing: 8,
                              onPressed: (_) async {
                                bool? isConfirmed =
                                    await showDeleteConfirmationDialog(
                                        context, selectedCourse.id!);
                                if (isConfirmed == true) {
                                  bloc.add(
                                    DeleteCourse(selectedCourse.id!),
                                  );
                                }
                              },
                            ),
                            SlidableAction(
                              label: l10n.edit,
                              // backgroundColor: Colors.amber,
                              icon: Icons.edit,
                              // spacing: 8,
                              onPressed: (_) {
                                context.push(
                                  addEditCourse,
                                  extra: bloc,
                                );
                                bloc.add(InitCourse(selectedCourse));
                              },
                            ),
                          ],
                        ),
                        child: ListTile(
                            title: Text(
                              bloc.courses[index].title,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            onTap: () {},
                            // context.push(course, extra: selectedCourse),
                            subtitle: Text(
                              bloc.courses[index].description.toString(),
                            ),
                            trailing: IconButton(
                              onPressed: () {
                                context
                                    .read<CoursesBloc>()
                                    .add(CopyCourseId(bloc.courses[index].id!));
                              },
                              icon: const FaIcon(Icons.bookmark),
                            )),
                      ),
                    );
                  },
                ),
              );
            } else {
              return Center(child: Text(l10n.noCourses));
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            bloc.editCourse = null;
            context.push(addEditCourse, extra: bloc);
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
