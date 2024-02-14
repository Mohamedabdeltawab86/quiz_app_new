import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:quiz_app_new/bloc/lesson/lesson_bloc.dart';
import 'package:quiz_app_new/data/models/lesson.dart';
import 'package:quiz_app_new/ui/screens/lesson_screen.dart';

import '../bloc/auth/auth_bloc.dart';
import '../bloc/course/course_bloc.dart';
import '../bloc/courses/courses_bloc.dart';
import '../bloc/user/user_info_bloc.dart';
import '../data/models/course.dart';
import '../data/repositories/question_repo.dart';
import '../ui/screens/add_edit_course.dart';
import '../ui/screens/course_page.dart';
import '../ui/screens/home.dart';
import '../ui/screens/login_page.dart';
import '../ui/screens/profile_screen.dart';
import '../ui/screens/register_page.dart';
import '../ui/screens/settings.dart';
import '../ui/screens/user_type.dart';

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
const String course = "/course";
const String lessonsPage = '/lesson';

late QuestionRepository questionRepository;

class AppRouter {
  // TODO: Pass initialLocation through the constructor
  final String initialLocation;

  // TODO: note that the router is late, as we will init it using _initRouter()
  late final GoRouter router;

  AppRouter(this.initialLocation) {
    // TODO: Initialize the router with the provided initialLocation
    _initRouter();
  }

  _initRouter() {
    router = GoRouter(
      // debugLogDiagnostics: true,
      initialLocation: initialLocation,

      routes: [
        GoRoute(
          path: home,
          builder: (context, state) {
            return BlocProvider(
              create: (context) => CoursesBloc()..add(FetchCourses()),
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
          builder: (context, state) => BlocProvider.value(
            value: state.extra as CoursesBloc,
            child: const AddEditCourse(),
          ),
        ),
        GoRoute(
          path: course,
          builder: (context, state) {
            return BlocProvider(
              create: (context) => CourseBloc(state.extra as Course),
              child: const CoursePage(),
            );
          },
        ),
        GoRoute(
          path: profile,
          builder: (context, state) {
            return BlocProvider(
              create: (context) => UserInfoBloc()..add(LoadProfile()),
              child: const ProfileScreen(),
            );
          },
        ),
        GoRoute(
          path: lessonsPage,
          builder: (context, state) {
            final courseId = state.pathParameters['course']!;
            final moduleId = state.pathParameters['moduleId']!;

            return BlocProvider.value(
              value: BlocProvider.of<CourseBloc>(context),
              child: LessonScreen(
                moduleId: moduleId,
                courseId: courseId,
              ),
            );
          },
        ),
      ],
    );
  }
}
