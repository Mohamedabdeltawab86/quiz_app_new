import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';
import '../../bloc/user/user_info_bloc.dart';
import '../widgets/login_form_text_field.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<UserInfoBloc>();
    final l10n = AppLocalizations.of(context)!;
    return Padding(
      padding:  EdgeInsets.all(8.0.sp),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Profile Screen'),
        ),
        body: BlocConsumer<UserInfoBloc, UserInfoState>(
          listener: (context, state) {
            if(state is UserInfoLoading){
              EasyLoading.show(status: "Loading");
            } else {
              EasyLoading.dismiss();
            }
          },
          buildWhen: (previous, current) => current is UserInfoLoaded,
          builder: (context, state) {
            return Form(
              key: bloc.profileFormKey,
              child: ListView(
                children: [
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
                  ElevatedButton.icon(
                    onPressed: () {
                      bloc.add(UpdateProfile());
                      context.pop();
                    },
                    icon: const FaIcon(FontAwesomeIcons.diceOne),
                    label: Text(l10n.finish),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
