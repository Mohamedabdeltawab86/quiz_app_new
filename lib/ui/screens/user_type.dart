import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';

import '../../bloc/auth/auth_bloc.dart';
import '../../utils/routes.dart';
import '../widgets/user_type_dropdown_button.dart';

class UserTypeAndInfo extends StatelessWidget {
  const UserTypeAndInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final bloc = context.read<AuthBloc>();
    return Padding(
      padding: EdgeInsets.all(8.0.sp),
      child: Scaffold(
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
                BlocBuilder<AuthBloc, AuthState>(
                  buildWhen: (previous, current) => current is UserInfoUpdated,
                  builder: (context, state) {
                    return ElevatedButton.icon(
                      onPressed: bloc.userType != null
                          ? () {
                              bloc.add(UserInfoSubmitted());
                              context.go(home);
                            }
                          : null,
                      icon: const FaIcon(FontAwesomeIcons.diceOne),
                      label: Text(l10n.finish),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
