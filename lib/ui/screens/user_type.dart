import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:quiz_app_new/utils/routes.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UserType extends StatelessWidget {
  const UserType({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
          // Your existing app bar content
        title: Text(""),
          ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
              onPressed: () {
                context.push(registerTeacher);
              },
              child:  Text(l10n.registerTeacher),
            ),
            const SizedBox(width: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to student registration page
                context.push(registerStudent);
              },
              child: Text(l10n.registerStudent),
            ),
          ],
        ),
      ),
    );
  }
}
