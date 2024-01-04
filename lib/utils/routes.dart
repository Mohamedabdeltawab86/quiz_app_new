import "package:flutter_bloc/flutter_bloc.dart";
import "package:go_router/go_router.dart";
import "package:quiz_app_new/bloc/auth/auth_bloc.dart";
import "package:quiz_app_new/ui/login_page.dart";
import "package:quiz_app_new/ui/register_page.dart";
import "package:quiz_app_new/ui/settings.dart";
import 'package:firebase_auth/firebase_auth.dart';

import "../ui/home.dart";

const String home = '/';
const String settings = '/settings';
const String login = '/login';
const String register = '/register';

/*
TODO: READ =>
  see how we provide the router to the main app only once.
  now when we rebuild or refresh the bloc won't rebuild itself.
*/
class AppRouter {
  final router = GoRouter(
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
        builder: (context, state) => BlocProvider(
          // TODO: read => see how create the bloc and provide it to login page.
          create: (context) => AuthBloc(),
          child: const LoginPage(),
        ),
      ),
      GoRoute(
        path: register,
        builder: (context, state) => BlocProvider.value(
          // TODO: read => see how we pass the value of bloc from the login page.
          value: state.extra! as AuthBloc,
          child: const RegisterPage(),
        ),
      ),
    ],
  );
}
