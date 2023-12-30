import "package:go_router/go_router.dart";
import "package:quiz_app_new/ui/settings.dart";

import "../ui/home.dart";

const String home = '/';
const String settings = '/settings';
const String progressScreen = '/progressScreen';

GoRouter router() {
  // TODO add bloc here

  return GoRouter(
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: home,
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: settings,
        builder: (context, state) => const Settings(),
      ),
    ],
  );
}
