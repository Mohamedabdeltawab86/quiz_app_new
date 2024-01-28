import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: Text(l10n.theme),
              trailing: Switch(
                value:
                    context.read<AppSettingsBloc>().state.appSettings.light,
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
          ],
        ),
      ),
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.appTitle),
        actions: [
          IconButton(
              onPressed: () => context.push(profile),
              icon: const Icon(Icons.verified_user_outlined))
        ],
      ),
        body: BlocBuilder<CourseBloc, CourseState>(
            builder: (context, state) {
              if (state is CourseFetchingState) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state is CourseFetchedState) {
                return ListView.builder(
                  itemCount: state. courses.length,
                  itemBuilder: (context, index) {
                    return Text(state.courses[index].title);
                  },
                );
              }

              // Handle error state
            return const SizedBox();
            }
        ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push(addEditCourse),
        child: const Icon(Icons.add),
      ),
    );
  }
} // body: ListView.build(
