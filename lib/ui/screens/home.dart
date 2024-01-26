import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:quiz_app_new/bloc/user/user_info_bloc.dart';
import 'package:quiz_app_new/utils/routes.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../bloc/settings_bloc/bloc/app_settings_bloc.dart';
import '../widgets/language_dropdown_button.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    // final bloc = context.read<UserInfoBloc>();
    // added listened in home to see if user has some null data,
    // but does not work
    return BlocListener<UserInfoBloc, UserInfoState>(
        listener: (context, state) {
          if (state is UserInfoLoaded) {
            if (state.user.userType == null ||
                state.user.phoneNumber == null ||
                state.user.firstName == null ||
                state.user.lastName == null) {
              print("some values are null");
              // delay to navigate
              Future.delayed(Duration.zero, () {
                context.go(userTypeAndInfo);
              });
            }
          }
        },
        child: Scaffold(
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
          body: Container(color: Colors.red),
          floatingActionButton: FloatingActionButton(
            onPressed: () => {},
            child: const Icon(Icons.add),
          ),
        ));
  }
}

// Future.delayed(Duration.zero, () {
//   context.push(userTypeAndInfo);
// });
// return Container();
