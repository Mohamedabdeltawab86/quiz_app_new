import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/src/widgets/basic.dart';
import "package:flutter_bloc/flutter_bloc.dart";
import "package:go_router/go_router.dart";
import "package:quiz_app_new/bloc/auth/auth_bloc.dart";
import 'package:quiz_app_new/bloc/profile/profile_bloc.dart';
import 'package:quiz_app_new/data/models/course.dart';
import 'package:quiz_app_new/data/models/user_profile.dart';
import 'package:quiz_app_new/ui/screens/login_page.dart';
import 'package:quiz_app_new/ui/screens/settings.dart';
import 'package:quiz_app_new/ui/screens/user_type.dart';

import '../bloc/course/course_bloc.dart';
import '../bloc/user/user_info_bloc.dart';
import '../data/repositories/question_repo.dart';
import '../ui/screens/add_edit_course.dart';
import '../ui/screens/home.dart';
import '../ui/screens/profile_screen.dart';
import '../ui/screens/register_page.dart';

const String home = '/';
const String settings = '/settings';
const String login = '/login';
const String register = '/register';
const String registerStudent = '/register_student';
const String registerTeacher = '/register_teacher';
const String userTypeAndInfo = '/userTypeAndInfo';
const String addEditCourse = '/addEditCourse';
const String quiz = '/quiz';
const String profile = '/profile';

late QuestionRepository questionRepository;

class AppRouter {
  final router = GoRouter(
    // debugLogDiagnostics: true,
    initialLocation: FirebaseAuth.instance.currentUser != null ? home : login,

    routes: [
      GoRoute(
        path: home,
        builder: (context, state) {
          final String userId = FirebaseAuth.instance.currentUser!.uid;
          return BlocProvider(
            create: (context) => UserInfoBloc(userId),
            child: const HomePage(),
          );
        },
      ),
      GoRoute(
        path: settings,
        builder: (context, state) => const Settings(),
      ),
      GoRoute(
        path: login,
        builder: (context, state) => BlocProvider(
          create: (context) => AuthBloc(),
          child: const LoginPage(),
        ),
      ),
      GoRoute(
        path: register,
        builder: (context, state) => BlocProvider.value(
          value: state.extra! as AuthBloc,
          child: const RegisterPage(),
        ),
      ),
      GoRoute(
        path: userTypeAndInfo,
        builder: (context, state) => BlocProvider(
          create: (context) => AuthBloc(),
          child: const UserTypeAndInfo(),
        ),
      ),
      GoRoute(
        path: addEditCourse,
        builder: (context, state) => BlocProvider(
          create: (context) => CourseBloc(course: state.extra as Course?),
          child: const AddEditCourse(),
        ),
      ),
      GoRoute(
        path: profile,
        builder: (context, state) {
          final String userId = FirebaseAuth.instance.currentUser!.uid;

          return BlocProvider(
            create: (context) => UserInfoBloc(userId),
            child: const ProfileScreen(),
          );
        },
      )
    ],
  );
}
