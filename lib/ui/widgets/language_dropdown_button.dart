import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app_new/bloc/settings_bloc/bloc/app_settings_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../data/models/language.dart';

class LanguageDropdownButton extends StatelessWidget {
  const LanguageDropdownButton({super.key, this.drawer = false});

  final bool drawer;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<Language>(
      underline: const SizedBox(),
      isExpanded: true,
      onChanged: (Language? language) async {
        context.read<AppSettingsBloc>().add(ChangeAppLocal(language!));
      },
      hint: drawer
          ? Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.sp),
              child: const Text("اللغة | Language"),
            )
          : const Center(child: Text("اللغة | Language")),
      items: Language.languageList()
          .map<DropdownMenuItem<Language>>(
            (e) => DropdownMenuItem<Language>(
              value: e,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    e.flag,
                    style: const TextStyle(fontSize: 30),
                  ),
                  Text(e.name)
                ],
              ),
            ),
          )
          .toList(),
      icon: drawer
          ? Padding(
              padding: EdgeInsets.symmetric(horizontal: 18.sp),
              child: const Icon(Icons.language),
            )
          : null,
    );
  }
}
