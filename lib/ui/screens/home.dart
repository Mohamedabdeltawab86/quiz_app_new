import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';
import 'package:quiz_app_new/bloc/course/course_bloc.dart';
import 'package:quiz_app_new/utils/routes.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../bloc/settings_bloc/bloc/app_settings_bloc.dart';
import '../widgets/language_dropdown_button.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final bloc = context.read<CourseBloc>();
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: Text(l10n.theme),
              trailing: Switch(
                value: context.read<AppSettingsBloc>().state.appSettings.light,
                onChanged: (_) {
                  context.read<AppSettingsBloc>().add(ChangeAppTheme());
                },
              ),
            ),
            const LanguageDropdownButton(),
            ListTile(
              leading: const Icon(Icons.exit_to_app),
              title: Text(l10n.signOut),
              onTap: () async {
                // Sign out logic
                // DONE: don't use context across async gaps. use then() to navigate.
                await FirebaseAuth.instance
                    .signOut()
                    .then((value) => context.go(login));
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text("user info"),
              onTap: () => context.push(profile),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.appTitle),
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
            return ListView.builder(
              itemCount: bloc.courses.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title: Text(bloc.courses[index].title),
                    subtitle: Text(bloc.courses[index].createdAt.toString()),
                  ),
                );
              },
            );
          } else {
            return Center(child: Text("No courses available"));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push(addEditCourse, extra: bloc),
        child: const Icon(Icons.add),
      ),
    );
  }
} // body: ListView.build(
