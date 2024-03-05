import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:quiz_app_new/data/models/user_profile.dart';
import 'package:quiz_app_new/ui/common.dart';
import 'package:quiz_app_new/ui/widgets/login_form_text_field.dart';
import 'package:quiz_app_new/utils/common_functions.dart';
import 'package:quiz_app_new/utils/routes.dart';
import 'package:sizer/sizer.dart';
import '../../bloc/auth/auth_bloc.dart';
import '../../bloc/settings_bloc/bloc/app_settings_bloc.dart';
import '../widgets/user_type_dropdown_button.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<AuthBloc>();
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        if (state is RegisterSuccess) {
          if (state.hasInfo) {
            await getCurrentUser().then((currentUser) {
              if (currentUser != null &&
                  currentUser.userType == UserType.teacher) {
                context.go(teachersHome);
              } else {
                context.go(studentsHome);
              }
            });
          } else {
            context.push(userTypeAndInfo, extra: bloc);
          }
        }
      },
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          // COMPLETED: READ => must add app bar to show the back button.
          appBar: AppBar(actions: [
            InkWell(
              onTap: () {
                if (kDebugMode) {
                  print(
                      context.read<AppSettingsBloc>().state.appSettings.light);
                }
                context.read<AppSettingsBloc>().add(ChangeAppTheme());
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  FontAwesomeIcons.moon,
                  color: context.read<AppSettingsBloc>().state.appSettings.light
                      ? Colors.grey
                      : Colors.black,
                ),
              ),
            ),
            // const LanguageDropdownButton(),
          ], backgroundColor: Colors.transparent),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.sp),
            child: Form(
              key: bloc.registerFormKey,
              child: ListView(
                children: [
                  heightGap,
                  // const CustomImage(
                  //   imagePath: "assets/masar.png",
                  // ),
                  heightGap,
                  Center(
                      child: Text(l10n.register,
                          style: theme.textTheme.displayMedium)),
                  heightGap,
                  // DONE: use the LoginTextField widget
                  QuizTextField(
                    controller: bloc.emailRegisterController,
                    icon: FontAwesomeIcons.envelope,
                    label: l10n.email,
                    keyboardType: TextInputType.emailAddress,
                    inputFormatters: [
                      FilteringTextInputFormatter.deny(RegExp(r"\s\b|\b\s"))
                    ],
                    // validator: bloc.validate('Please enter your email!'),
                  ),
                  // Gap(5.sp),
                  heightGap,
                  QuizTextField(
                    controller: bloc.firstNameController,
                    icon: Icons.person,
                    label: l10n.firstName,
                    validator: (value) {
                      if (value != null && value.isNotEmpty) {
                        return null;
                      } else {
                        return l10n.emptyField;
                      }
                    },
                  ),
                  // Gap(5.sp),
                  heightGap,
                  QuizTextField(
                    controller: bloc.lastNameController,
                    icon: Icons.person,
                    label: l10n.lastName,
                    validator: (value) {
                      if (value != null && value.isNotEmpty) {
                        return null;
                      } else {
                        return l10n.emptyField;
                      }
                    },
                  ),
                  // Gap(5.sp),
                  heightGap,
                  QuizTextField(
                    controller: bloc.phoneNumberController,
                    icon: Icons.phone,
                    keyboardType: TextInputType.phone,
                    digitsOnly: true,
                    label: l10n.phone,
                    // TODO: later: validate phone number passed on country
                    validator: (value) {
                      if (value != null && value.isNotEmpty) {
                        return null;
                      } else {
                        return l10n.emptyField;
                      }
                    },
                  ),
                  heightGap,
                  QuizTextField(
                    controller: bloc.passRegisterController,
                    icon: FontAwesomeIcons.lock,
                    label: l10n.password,
                    isEmail: false,
                    obscureText: true,
                  ),
                  heightGap,
                  QuizTextField(
                    controller: bloc.passConfirmController,
                    icon: FontAwesomeIcons.lock,
                    label: l10n.confirmPassword,
                    isEmail: false,
                    obscureText: true,
                    validator: (confirmedPassword) => isSamePassword(
                      pass: bloc.passRegisterController.text,
                      passConfirm: bloc.passConfirmController.text,
                      emptyMessage: l10n.emptyField,
                      mismatchMessage: l10n.mismatch,
                    ),
                  ),

                  Row(
                    children: [
                      Text(l10n.userType),
                      Gap(5.sp),
                      Expanded(
                        child: BlocBuilder<AuthBloc, AuthState>(
                          buildWhen: (_, current) => current is UserInfoUpdated,
                          builder: (context, state) {
                            // TODO: make sure you have a default value here.
                            return UserTypeDropdownButton(
                              isRegister: true,
                              onChanged: (type) => bloc.add(ChangeType(type!)),
                              value: bloc.userType,
                            );
                          },
                        ),
                      ),
                    ],
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
                  Center(child: Text(l10n.or)),
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
