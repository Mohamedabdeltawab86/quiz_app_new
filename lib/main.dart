import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:quiz_app_new/bloc/settings_bloc/bloc/app_settings_bloc.dart';
import 'package:quiz_app_new/bloc_observer.dart';
import 'package:quiz_app_new/utils/color_schemes.g.dart';
import 'package:quiz_app_new/utils/routes.dart';
import 'package:quiz_app_new/utils/typography.dart';
import 'package:sizer/sizer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getTemporaryDirectory(),
  );
  Bloc.observer = MyBlocObserver();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp(appRouter: AppRouter()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.appRouter});

  final AppRouter appRouter;

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return BlocProvider(
        create: (context) => AppSettingsBloc()..add(AppSettingsStarted()),
        child: BlocBuilder<AppSettingsBloc, AppSettingsState>(
          buildWhen: (previous, current) =>
              previous.appSettings != current.appSettings,
          builder: (context, state) {
            return MaterialApp.router(
              title: 'Quiz App',
              theme: ThemeData(
                useMaterial3: true,
                colorScheme: lightColorScheme,
                textTheme: textTheme,
              ),
              darkTheme: ThemeData(
                useMaterial3: true,
                colorScheme: darkColorScheme,
                textTheme: textTheme,
              ),
              themeMode:
                  state.appSettings.light ? ThemeMode.light : ThemeMode.dark,
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              builder: EasyLoading.init(),
              supportedLocales: AppLocalizations.supportedLocales,
              locale: Locale(state.appSettings.local.languageCode),
              routerConfig: appRouter.router,
            );
          },
        ),
      );
    });
  }
}
