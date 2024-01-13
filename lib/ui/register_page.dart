import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:quiz_app_new/ui/common.dart';
import 'package:quiz_app_new/ui/widgets/login_form_text_field.dart';
import 'package:quiz_app_new/utils/common_functions.dart';
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
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is RegisterSuccess) context.go(home);
      },
      // Done: add gesture detector to remove focus when clicking elsewhere
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          // COMPLETED: READ => must add app bar to show the back button.
          appBar: AppBar(backgroundColor: Colors.transparent),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.sp),
            child: Form(
              key: bloc.registerFormKey,
              child: ListView(
                children: [
                  heightGap,
                  Text(l10n.register, style: theme.textTheme.displayMedium),
                  heightGap,
                  // DONE: use the LoginTextField widget
                  LoginTextField(
                    controller: bloc.emailRegisterController,
                    icon: FontAwesomeIcons.envelope,
                    label: l10n.email,
                    // validator: bloc.validate('Please enter your email!'),
                  ),
                  heightGap,
                  LoginTextField(
                    controller: bloc.passRegisterController,
                    icon: FontAwesomeIcons.lock,
                    label: l10n.password,
                    isEmail: false,
                  ),
                  heightGap,
                  LoginTextField(
                    controller: bloc.passConfirmController,
                    icon: FontAwesomeIcons.lock,
                    label: l10n.confirmPassword,
                    isEmail: false,
                    validator: (confirmedPassword) => isSamePassword(
                      pass: bloc.passRegisterController.text,
                      passConfirm: bloc.passConfirmController.text,
                      emptyMessage: l10n.emptyField,
                      mismatchMessage: l10n.mismatch,
                    ),
                  ),
                  heightGap,
                  BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state) {
                      return ElevatedButton.icon(
                        onPressed: () => bloc.add(RegisterWithEmailPassword()),
                        icon: (state is RegisterLoading)
                            ? const Center(child: CircularProgressIndicator())
                            : const FaIcon(FontAwesomeIcons.user),
                        label: (state is RegisterLoading)
                            ? const Text("")
                            : Text(l10n.register),
                      );
                    },
                  ),

                  heightGap,
                  const Center(child: Text("or")),
                  heightGap,
                  ElevatedButton.icon(
                    onPressed: () => bloc.add(LoginWithGoogle()),
                    icon: const FaIcon(FontAwesomeIcons.google),
                    label: Text(AppLocalizations.of(context)!.googleLogin),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
