import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});
  // TODO switch between create account and login page
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const Gap(50),
             Text(AppLocalizations.of(context)!.login, style: Theme.of(context).textTheme.displayMedium),
            const Gap(50),
             SizedBox(
              width: 450,
              child: TextField(
                decoration: InputDecoration(
                  border:  const OutlineInputBorder(),
                  labelText: AppLocalizations.of(context)!.email,
                  // FIXME no email or password icons in awesome package
                  prefixIcon: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: FaIcon(FontAwesomeIcons.envelope),
                  ),
                ),
              ),
            ),
            const Gap(20),
            SizedBox(
              width: 450,
              child: TextField(
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: AppLocalizations.of(context)!.password,
                  prefixIcon: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: FaIcon(FontAwesomeIcons.lock),
                  ),
                ),
              ),
            ),
            const Gap(20),
            ElevatedButton.icon(
                onPressed: () {},
                icon: const FaIcon(FontAwesomeIcons.user),
                label:  Text(AppLocalizations.of(context)!.login)),
            const Gap(20),
            const Text("or"),
            const Gap(20),
            ElevatedButton.icon(
                onPressed: () {},
                icon: const FaIcon(FontAwesomeIcons.google,),
                label: Text(AppLocalizations.of(context)!.googlelogin)),
          ],
        ),
      ),
    );
  }
}
