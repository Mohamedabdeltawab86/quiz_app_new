import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:quiz_app_new/bloc/auth/auth_bloc.dart';
import 'package:quiz_app_new/ui/widgets/login_form_text_field.dart';
import 'package:sizer/sizer.dart';

import '../utils/routes.dart';
import 'common.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  // TODO switch between create account and login page
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<AuthBloc>();
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    return GestureDetector(
      // onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.sp),
          // TODO: add validator and use the form.
          child: Form(
            child: ListView(
              children: [
                heightGap,
                Text(l10n.login, style: theme.textTheme.displayMedium),
                heightGap,
                LoginTextField(
                  controller: bloc.emailController,
                  icon: FontAwesomeIcons.envelope,
                  label: l10n.email,
                ),
                heightGap,
                LoginTextField(
                  controller: bloc.passController,
                  icon: FontAwesomeIcons.lock,
                  label: l10n.password,
                ),
                heightGap,
                ElevatedButton.icon(
                  onPressed: () => bloc.add(LoginWithUserPassword()),
                  icon: const FaIcon(FontAwesomeIcons.user),
                  label: Text(l10n.login),
                ),
                heightGap,
                const Center(child: Text("or")),
                heightGap,
                ElevatedButton.icon(
                  onPressed: () => bloc.add(LoginWithGoogle()),
                  icon: const FaIcon(FontAwesomeIcons.google),
                  label: Text(l10n.googlelogin),
                ),
                heightGap,
                ElevatedButton.icon(
                  /*
                  TODO: READ =>
                    use push instead of go to keep the
                    previous stack the same (with the same context)
                    so you can pass the bloc
                  */
                  onPressed: () => context.push(register, extra: bloc),
                  icon: const FaIcon(FontAwesomeIcons.user),
                  label: Text(l10n.register),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
