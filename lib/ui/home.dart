import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:quiz_app_new/utils/routes.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../bloc/settings_bloc/bloc/app_settings_bloc.dart';
import 'widgets/language_dropdown_button.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: Text(AppLocalizations.of(context)!.theme),
              trailing: Switch(
                value: context.read<AppSettingsBloc>().state.appSettings.light,
                onChanged: (_) {
                  context.read<AppSettingsBloc>().add(ChangeAppTheme());
                },
              ),
            ),
            // ListTile(
            //   title: Text(AppLocalizations.of(context)!.language),
            //   trailing: Switch(
            //     value: context.read<AppSettingsBloc>().state.appSettings.light,
            //     onChanged: (_) {
            //       context.read<AppSettingsBloc>().add(ChangeAppLocal());
            //     },
            //   ),
            // ),
            const LanguageDropdownButton(),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.appTitle),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              child: FilledButton(
                  onPressed: () => context.push(settings),
                  child: Text(AppLocalizations.of(context)!.settings)),
            ),
            const Gap(30),
            SizedBox(
              child: FilledButton(
                  onPressed: () => context.push(progressScreen),
                  child: Text(AppLocalizations.of(context)!.progress)),
            ),
          ],
        ),
      ),
    );
  }
}
