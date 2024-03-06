import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:quiz_app_new/bloc/lesson/lesson_bloc.dart';
import 'package:quiz_app_new/bloc/questions/questions_bloc.dart';
import 'package:quiz_app_new/data/models/add_lesson_data_model.dart';
import 'package:quiz_app_new/ui/auth/login_page.dart';
import 'package:quiz_app_new/ui/screens/add_question_screen.dart';
import 'package:quiz_app_new/ui/screens/lesson_screen.dart';
import 'package:quiz_app_new/ui/screens/students_home.dart';

import '../bloc/auth/auth_bloc.dart';
import '../bloc/course/course_bloc.dart';
import '../bloc/courses/courses_bloc.dart';
import '../bloc/user/user_info_bloc.dart';
import '../data/models/course.dart';
import '../data/repositories/question_repo.dart';
import '../data/repositories/students_repo/students_repo.dart';
import '../ui/auth/profile_screen.dart';
import '../ui/auth/register_page.dart';
import '../ui/auth/user_type.dart';
import '../ui/auth/verify_email.dart';
import '../ui/screens/add_edit_course.dart';
import '../ui/screens/course_page.dart';
import '../ui/screens/teachers_home.dart';

import '../ui/screens/settings.dart';

const String teachersHome = '/';
const String studentsHome = '/studentsHome';
const String settings = '/settings';
const String login = '/login';
const String register = '/register';
const String verifyEmail = '/verifyEmail';
const String registerStudent = '/register_student';
const String registerTeacher = '/register_teacher';
const String userTypeAndInfo = '/userTypeAndInfo';
const String addEditCourse = '/addEditCourse';
const String quiz = '/quiz';
const String profile = '/profile';
const String course = "/course";
const String lessonsPage = '/lesson';
const String addEditQuestion = '/addEditQuestion';

late QuestionRepository questionRepository;

class AppRouter {
  final String initialLocation;

  late final GoRouter router;

  AppRouter(this.initialLocation) {
    _initRouter();
  }

  _initRouter() {
    router = GoRouter(
      debugLogDiagnostics: true,
      initialLocation: initialLocation,
      routes: [
        GoRoute(
          path: teachersHome,
          builder: (context, state) {
            return BlocProvider(
              create: (context) => CoursesBloc()..add(FetchCourses()),
              child: const TeachersHome(),
            );
          },
        ),
        GoRoute(
          path: studentsHome,
          builder: (context, state) {
            return RepositoryProvider(
              create: (context) => StudentsRepo(),
              child: const StudentsHome(),
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
          path: verifyEmail,
          builder: (context, state) => BlocProvider.value(
            value: state.extra! as AuthBloc,
            child: const EmailVerificationScreen(),
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
          path:
              '/courses/:courseId/modules/:moduleId/lessons/:lessonId/lesson/:lessonTitle',
          builder: (context, state) {
            final courseId = state.pathParameters['courseId']!;
            final moduleId = state.pathParameters['moduleId']!;
            final lessonId = state.pathParameters['lessonId']!;
            final lessonTitle = state.pathParameters['lessonTitle']!;

            return BlocProvider(
              create: (context) => LessonBloc()
                ..add(LoadLesson(
                  courseId: courseId,
                  moduleId: moduleId,
                  lessonId: lessonId,
                )),
              child: LessonScreen(
                courseId: courseId,
                moduleId: moduleId,
                lessonId: lessonId,
                lessonTitle: lessonTitle,
              ),
            );
          },
        ),
        GoRoute(
            path: addEditQuestion,
            builder: (context, state) {
              final arguments = state.extra as QuestionScreenArguments;
              return BlocProvider(
                create: (context) => QuestionsBloc(arguments),
                child: const AddEditQuestionScreen(),
              );
            }),
      ],
    );
  }
}
