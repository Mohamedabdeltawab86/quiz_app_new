import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';
import 'package:quiz_app_new/bloc/course/course_bloc.dart';
import 'package:quiz_app_new/utils/routes.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:sizer/sizer.dart';

import '../widgets/home_widgets/drawer.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final bloc = context.read<CourseBloc>();
    return Padding(
      padding: EdgeInsets.all(8.0.sp),
      child: Scaffold(
        drawer: const HomeDrawer(),
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.courses),
        ),
        body: BlocConsumer<CourseBloc, CourseState>(
          listener: (context, state) {
            if (state is CourseFetching) {
              EasyLoading.show(status: "Loading");
            } else if (state is AddingCourseDone) {
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
                    return Card(
                      // TODO 3: make edit available
                      child: GestureDetector(
                        onTap: () => context.push(addEditCourse, extra: bloc),
                        child: ListTile(
                          title: Text(
                            bloc.courses[index].title,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle:
                              Text(bloc.courses[index].description.toString()),
                        ),
                      ),
                    );
                  },
                ),
              );
            } else {
              return const Center(child: Text("No courses available"));
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => context.push(addEditCourse, extra: bloc),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

