import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:quiz_app_new/bloc/auth/auth_bloc.dart';
import 'package:quiz_app_new/ui/widgets/login_form_text_field.dart';
import 'package:sizer/sizer.dart';

import '../utils/routes.dart';
import 'comman.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  // TODO switch between create account and login page
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<AuthBloc>();
    return GestureDetector(
      // onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.sp),
          child: Form(
            child: ListView(
              children: [
                heightGap,
                Text(
                  AppLocalizations.of(context)!.login,
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                heightGap,
                LoginTextField(
                  controller: bloc.emailController,
                  icon: FontAwesomeIcons.envelope,
                  label: AppLocalizations.of(context)!.email,
                ),
                heightGap,
                LoginTextField(
                  controller: bloc.passController,
                  icon: FontAwesomeIcons.lock,
                  label: AppLocalizations.of(context)!.password,
                ),
                Gap(10.h),
                ElevatedButton.icon(
                    onPressed: () => bloc.add(LoginWithUserPassword()),
                    icon: const FaIcon(FontAwesomeIcons.user),
                    label: Text(AppLocalizations.of(context)!.login)),
                Gap(10.h),
                const Text("or"),
                Gap(10.h),
                ElevatedButton.icon(
                    onPressed: () => bloc.add(LoginWithGoogle()),
                    icon: const FaIcon(
                      FontAwesomeIcons.google,
                    ),
                    label: Text(AppLocalizations.of(context)!.googlelogin)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
