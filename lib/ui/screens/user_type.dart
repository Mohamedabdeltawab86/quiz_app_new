import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:quiz_app_new/utils/common_functions.dart';
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
                          onChanged: (t) => bloc.add(ChangeType(t)),
                          value: bloc.userType,
                        );
                      },
                    ),
                  ),
                ],
              ),
              Divider(height: 15.sp, endIndent: 10.w, indent: 10.w),
              // TODO: quiz: make sure the new type reflects on the button.
              ElevatedButton.icon(
                onPressed: bloc.userType != null
                    ? () {
                      bloc.add(UserInfoSubmitted());
                      context.pop();
                    }
                    : null,
                icon: const FaIcon(FontAwesomeIcons.diceOne),
                label: Text(l10n.finish),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
