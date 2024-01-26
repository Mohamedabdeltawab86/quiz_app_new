import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../bloc/user/user_info_bloc.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<UserInfoBloc>();
    // final l10n = AppLocalizations.of(context)!;
    return Scaffold(
        appBar: AppBar(
          title: const Text('kkk'),
        ),
        body:
            BlocBuilder<UserInfoBloc, UserInfoState>(builder: (context, state) {
          if (state is UserInfoError) {
            print(state.error);
          } else if (state is UserInfoLoading) {
            print("state");
          } else if (state is UserInfoLoaded) {
            final profile = state.user;
            print(profile);
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(profile.userType!.toString()),
                CircleAvatar(
                  backgroundImage: NetworkImage(profile.photoUrl!),
                ),
                Text('${profile.firstName!} + ${profile.lastName!}'),
                Text(profile.email),
                Text(profile.phoneNumber!),
              ],
            );
          }
          return Container();
        }));
  }
}
