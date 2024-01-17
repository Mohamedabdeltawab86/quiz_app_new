import "package:flutter_bloc/flutter_bloc.dart";
import "package:go_router/go_router.dart";
import "package:quiz_app_new/bloc/auth/auth_bloc.dart";
import 'package:quiz_app_new/bloc/quiz/quiz_bloc.dart';
import 'package:quiz_app_new/ui/screens/login_page.dart';
import 'package:quiz_app_new/ui/screens/register_student.dart';
import 'package:quiz_app_new/ui/screens/settings.dart';
import 'package:quiz_app_new/ui/screens/user_type.dart';

import '../data/repositories/question_repo.dart';
import '../ui/screens/home.dart';
import '../ui/screens/quiz/quiz_view.dart';
import '../ui/screens/register_page.dart';
import '../ui/screens/register_teacher.dart';

const String home = '/';
const String settings = '/settings';
const String login = '/login';
const String register = '/register';
const String registerStudent = '/register_student';
const String registerTeacher = '/register_teacher';
const String userType = '/user_type';
const String quiz = '/quiz';

late  QuestionRepository questionRepository;
class AppRouter {
  final router = GoRouter(
    // debugLogDiagnostics: true,
    // initialLocation: FirebaseAuth.instance.currentUser != null ? home : login,
    initialLocation: quiz,
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
        path: registerTeacher,
        builder: (context, state) => const TeacherRegisterPage(),
      ),
      GoRoute(
        path: registerStudent,
        builder: (context, state) => const StudentRegisterPage(),
      ),
      GoRoute(
        path: userType,
        builder: (context, state) => const UserType(),
      ),
      GoRoute(
        path: quiz,
        builder: (context, state) {
          final questionRepository = context.read<QuestionRepository>(); // Access repository via Provider
          return BlocProvider(
            create: (context) => QuizBloc(questionRepository),
            child: const QuestionView(),
          );
        },
      ),
    ],
  );
}
