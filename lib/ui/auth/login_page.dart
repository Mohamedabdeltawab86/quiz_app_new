import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:quiz_app_new/bloc/auth/auth_bloc.dart';
import 'package:quiz_app_new/ui/widgets/login_form_text_field.dart';
import 'package:quiz_app_new/ui/widgets/custom_image.dart';
import 'package:sizer/sizer.dart';
import '../../bloc/settings_bloc/bloc/app_settings_bloc.dart';
import '../../data/models/user_profile.dart';
import '../../utils/common_functions.dart';
import '../../utils/routes.dart';
import '../common.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<AuthBloc>();
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) async {
          if (state is LoginSuccess) {
            if (state.hasInfo) {
              await getCurrentUser().then((currentUser) {
                if (currentUser != null &&
                    !FirebaseAuth.instance.currentUser!.emailVerified) {
                  context.go(verifyEmail);
                } else {
                  if (currentUser?.userType == UserType.teacher) {
                    log("verified");
                    context.go(teachersHome);
                  } else {
                    log("verified");
                    context.go(studentsHome);
                  }
                }
              });
            } else if (!state.hasInfo) {
              context.go(userTypeAndInfo, extra: bloc);
            }
          }
        },
        child: Scaffold(
          appBar: AppBar(
            actions: [
              InkWell(
                onTap: () {
                  context.read<AppSettingsBloc>().add(ChangeAppTheme());
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    FontAwesomeIcons.moon,
                    color:
                        context.read<AppSettingsBloc>().state.appSettings.light
                            ? Colors.grey
                            : Colors.black,
                  ),
                ),
              ),
              // const LanguageDropdownButton(),
            ],
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.sp),
            // DONE: add validator and use the form.
            child: Form(
              key: bloc.formKey,
              child: ListView(
                children: <Widget>[
                  heightGap,
                  const CustomImage(imagePath: "assets/masar.png"),
                  heightGap,
                  Center(
                      child: Text(l10n.login,
                          style: theme.textTheme.displayMedium)),
                  heightGap,
                  QuizTextField(
                    controller: bloc.emailController,
                    icon: FontAwesomeIcons.envelope,
                    label: l10n.email,
                    keyboardType: TextInputType.emailAddress,
                    // inputFormatters: [
                    //   FilteringTextInputFormatter.deny(RegExp(r"\s\b|\b\s"))
                    // ],
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return l10n.enterEmail;
                      } else if (!regex.hasMatch(value)) {
                        return "Invalid email format";
                      }
                      return null;
                    },
                  ),
                  heightGap,
                  QuizTextField(
                    controller: bloc.passController,
                    icon: FontAwesomeIcons.lock,
                    label: l10n.password,
                    isEmail: false,
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return l10n.enterPass;
                      } else if (value.length < 8) {
                        return "Password is too short";
                      }
                      return null;
                    },
                  ),
                  heightGap,
                  BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state) {
                      return ElevatedButton.icon(
                        onPressed: () => bloc.add(LoginWithUserPassword()),
                        icon: (state is LoginLoading)
                            ? const Center(child: CircularProgressIndicator())
                            : const FaIcon(FontAwesomeIcons.user),
                        label: (state is LoginLoading)
                            ? const Text("")
                            : Text(l10n.login),
                      );
                    },
                  ),
                  heightGap,
                  Center(child: Text(l10n.or)),
                  heightGap,
                  ElevatedButton.icon(
                    onPressed: () => bloc.add(LoginWithGoogle()),
                    icon: const FaIcon(FontAwesomeIcons.google),
                    label: Text(l10n.googleLogin),
                  ),
                  heightGap,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(l10n.haveNoAccount),
                      InkWell(
                        onTap: () => context.push(register, extra: bloc),
                        child: Text(
                          l10n.register,
                          style: const TextStyle(color: Colors.blue),
                        ),
                      ),
                    ],
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
