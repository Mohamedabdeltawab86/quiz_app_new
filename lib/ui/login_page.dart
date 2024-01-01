import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const Gap(50),
            const SizedBox(
              width: 450,
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email),
                  ),
                ),
              ),

            ElevatedButton.icon(
                onPressed: () {},
                icon: const FaIcon(FontAwesomeIcons.user),
                label: const Text('Sign In with Email')),
            const Gap(10),
            ElevatedButton.icon(
                onPressed: () {},
                icon: const FaIcon(FontAwesomeIcons.google),
                label: const Text('Sign In with GOOGLE')),
          ],
        ),
      ),
    );
  }
}
