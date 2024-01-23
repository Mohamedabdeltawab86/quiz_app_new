import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:sizer/sizer.dart';

import '../../bloc/auth/auth_bloc.dart';
import '../widgets/login_form_text_field.dart';
import '../widgets/user_type_dropdown_button.dart';

class UserTypeAndInfo extends StatelessWidget {
  const UserTypeAndInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final bloc = context.read<AuthBloc>();
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.userInfoPage),
      ),
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Form(
          key: bloc.userInfoKey,
          child: ListView(
            children: [
              Row(
                children: [
                  Text(l10n.userType),
                  Gap(5.sp),
                  Expanded(
                    child: BlocBuilder<AuthBloc, AuthState>(
                      buildWhen: (_, current) => current is UserInfoUpdated,
                      builder: (context, state) {
                        return UserTypeDropdownButton(
                          onChanged: (type) => bloc.add(TypeChanged(type!)),
                          value: bloc.userType,
                        );
                      },
                    ),
                  ),
                ],
              ),
              // TODO: add circle avatar to choose photo
              Gap(5.sp),
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
              Gap(5.sp),
              QuizTextField(
                controller: bloc.lastNameController,
                icon: Icons.person,
                label: l10n.lastName,
                validator: (_) => null,
              ),
              Gap(5.sp),
              QuizTextField(
                controller: bloc.phoneNumberController,
                icon: Icons.phone,
                keyboardType: TextInputType.phone,
                digitsOnly: true,
                label: l10n.phone,
                // TODO: later: validate phone number passed on country
                validator: (_) => null,
              ),
              Divider(height: 15.sp, endIndent: 10.w, indent: 10.w),
              ElevatedButton.icon(
                onPressed: () => bloc.add(UserInfoSubmitted()),
                icon: const FaIcon(FontAwesomeIcons.diceOne),
                label: Text(l10n.finish),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        bloc.doesUserHasInfo("A1kZSAg7qTSbLmFBJewbCMKQBCC2").toString();
      }),
    );
  }
}
