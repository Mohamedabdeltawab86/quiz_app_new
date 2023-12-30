import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:quiz_app_new/bloc/settings_bloc/bloc/app_settings_bloc.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
title: Text(AppLocalizations.of(context)!.settings),
      ),
      body: Center(
        child: BlocBuilder<AppSettingsBloc, AppSettingsState>(
          builder: (context, state) {
            return Column(
              children: [
                Text(state.toString()),
                TextButton(
                  onPressed: () {}, child: const Text('Login'),
                ),
                TextButton(onPressed: (){}, child: const Text('Logout')),
              ],
            );
          },
        ),
      ),
    );
  }
}
