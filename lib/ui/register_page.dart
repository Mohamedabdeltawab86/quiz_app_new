import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:quiz_app_new/ui/common.dart';
import 'package:quiz_app_new/ui/widgets/login_form_text_field.dart';
import 'package:quiz_app_new/utils/routes.dart';
import 'package:sizer/sizer.dart';

import '../bloc/auth/auth_bloc.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<AuthBloc>();
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    return Scaffold(
      // TODO: READ => must add app bar to show the back button.
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30.sp),
        child: Form(
          key: bloc.formKey,
          child: ListView(
            children: [
              heightGap,
              Text(l10n.register, style: theme.textTheme.displayMedium),
              heightGap,
              // TODO: use the LoginTextField widget
              LoginTextField(
                controller: bloc.emailController,
                icon: FontAwesomeIcons.envelope,
                label: l10n.email,
                validationMessage: 'Please enter your email!',
                // validator: bloc.validate('Please enter your email!'),
              ),
              heightGap,
              LoginTextField(
                controller: bloc.passController,
                icon: FontAwesomeIcons.lock,
                label: l10n.password,
                validationMessage: 'Please enter your password!',
              ),
              heightGap,
              ElevatedButton.icon(
                  onPressed: () {
                    bloc.add(RegisterwithEmailPassword());
                  },
                  icon: const FaIcon(FontAwesomeIcons.user),
                  label: Text(l10n.register),),

              heightGap,
              const Center(child: Text("or")),
              heightGap,
              ElevatedButton.icon(
                onPressed: () => bloc.add(LoginWithGoogle()),
                icon: const FaIcon(FontAwesomeIcons.google),
                label: Text(AppLocalizations.of(context)!.googlelogin),
              ),
              heightGap,
              // TODO: read => see how the bloc closes when we leave the scope.
              ElevatedButton.icon(
                onPressed: () => context.go(home),
                icon: const FaIcon(FontAwesomeIcons.house),
                label: const Text('Home'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
