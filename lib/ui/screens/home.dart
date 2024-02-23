import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:go_router/go_router.dart';

import 'package:quiz_app_new/utils/routes.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:sizer/sizer.dart';

import '../../bloc/courses/courses_bloc.dart';
import '../widgets/home_widgets/drawer.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
              EasyLoading.show(status: "Loading");
            } else if (state is AddingCourseDone) {
              bloc.add(FetchCourses());
            } else if (state is DeletingCourseSuccess) {
              bloc.add(FetchCourses());
            } else if (state is UpdatingCourseSuccess) {
              bloc.add(FetchCourses());
            } else {
              EasyLoading.dismiss();
            }
          },
          buildWhen: (previous, current) => current is CourseFetched,
          builder: (context, state) {
            if (bloc.courses.isNotEmpty) {
              return RefreshIndicator(
                onRefresh: () async => bloc.add(FetchCourses()),
                child: ListView.builder(
                  itemCount: bloc.courses.length,
                  itemBuilder: (context, index) {
                    final selectedCourse = bloc.courses[index];
                    return Card(
                      // TODO 3: make edit available
                      child: Slidable(
                        endActionPane: ActionPane(
                          motion: const ScrollMotion(),
                          children: [
                            SlidableAction(
                              label: 'Delete',
                              backgroundColor: Colors.amber,
                              icon: Icons.delete,
                              spacing: 8,
                              onPressed: (context) => bloc.add(
                                DeleteCourse(selectedCourse.id!),
                              ),
                            ),
                            SlidableAction(
                              label: 'Edit',
                              backgroundColor: Colors.amber,
                              icon: Icons.edit,
                              spacing: 8,
                              onPressed: (_) {
                                context.push(
                                  addEditCourse,
                                  extra: bloc,
                                );
                                bloc.add(UpdateCourse(selectedCourse));
                              },
                            ),
                          ],
                        ),
                        child: ListTile(
                          title: Text(
                            bloc.courses[index].title,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          onTap: () =>
                              context.push(course, extra: selectedCourse),
                          subtitle: Text(
                            bloc.courses[index].description.toString(),
                          ),
                        ),
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
          onPressed: () => context.push(
            addEditCourse,
            extra: bloc,
          ),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
