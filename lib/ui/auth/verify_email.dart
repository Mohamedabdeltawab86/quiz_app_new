import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app_new/bloc/auth/auth_bloc.dart';

class EmailVerificationScreen extends StatelessWidget {
  const EmailVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<AuthBloc>();
    return Scaffold(
      appBar: AppBar(title: const Text("Verify Your Email")),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
        if (state is EmailVerificationSent){
          
        }
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                  "A verification email has been sent to your email address. Please verify your email to continue."),
              ElevatedButton(
                onPressed: () {
                  bloc.add(ResendEmailVerification());
                },
                child: const Text("Resend Email"),
              ),
              ElevatedButton(
                onPressed: () {
                  bloc.add(SignOut());
                },
                child: const Text("Logout"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
