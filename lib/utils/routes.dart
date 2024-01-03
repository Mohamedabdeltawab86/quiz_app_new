import "package:flutter_bloc/flutter_bloc.dart";
import "package:go_router/go_router.dart";
import "package:quiz_app_new/bloc/auth/auth_bloc.dart";
import "package:quiz_app_new/ui/login_page.dart";
import "package:quiz_app_new/ui/settings.dart";
import 'package:firebase_auth/firebase_auth.dart';

import "../ui/home.dart";

const String home = '/';
const String settings = '/settings';
const String login = '/login';
const String register = '/register';

AuthBloc authBloc = AuthBloc();

GoRouter router() {
  return GoRouter(
    // debugLogDiagnostics: true,
    initialLocation: FirebaseAuth.instance.currentUser != null ? home : login,
    routes: [
      GoRoute(
        path: home,
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: settings,
        builder: (context, state) => const Settings(),
      ),
      GoRoute(
        path: login,
        builder: (context, state) => BlocProvider.value(
          value: authBloc,
          child: const LoginPage(),
        ),
      ),
      GoRoute(
        path: register,
        builder: (context, state) => BlocProvider.value(
          value: authBloc,
          child: const LoginPage(),
        ),
      ),
    ],
  );
}
