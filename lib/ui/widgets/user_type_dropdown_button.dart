import 'package:flutter/material.dart';
import 'package:quiz_app_new/data/models/user_profile.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UserTypeDropdownButton extends StatelessWidget {
  final void Function(UserType?) onChanged;
  final UserType? value;
  final bool isRegister;

  const UserTypeDropdownButton({
    super.key,
    required this.onChanged,
    required this.value,
    this.isRegister = false,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return DropdownButton<UserType>(
      items: [
        if(!isRegister)
        const DropdownMenuItem(
          value: null,
          child: Center(child: Text("nothing")),
        ),
        ...UserType.values.map(
          (e) => DropdownMenuItem(
            value: e,
            child: Center(child: Text(l10n.translateUserType(e))),
          ),
        )
      ],
      onChanged: onChanged,
      value: value,
      isExpanded: true,
    );
  }
}

extension AppLocalizationsExtension on AppLocalizations {
  String translateUserType(UserType type) {
    switch (type) {
      case UserType.student:
        return student;
      default:
        return teacher;
    }
  }
}
