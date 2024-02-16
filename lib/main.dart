import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:quiz_app_new/bloc/settings_bloc/bloc/app_settings_bloc.dart';
import 'package:quiz_app_new/bloc_observer.dart';
import 'package:quiz_app_new/utils/color_schemes.g.dart';
import 'package:quiz_app_new/utils/common_functions.dart';
import 'package:quiz_app_new/utils/routes.dart';
import 'package:quiz_app_new/utils/typography.dart';
import 'package:sizer/sizer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'data/models/language.dart';
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
  runApp(MyApp(appRouter: AppRouter(await getInitialLocation())));
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
            print(state.appSettings.local == const Language.initial(id: 2));
            print(
                "Current language is ${state.appSettings.local.name} and ID == ${state.appSettings.local.id})");
            EasyLoading.instance.maskType = EasyLoadingMaskType.black;
            return MaterialApp.router(
              debugShowCheckedModeBanner: false,
              title: 'Quiz App',
              theme: FlexThemeData.light(
                scheme: FlexScheme.purpleM3,
                surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
                blendLevel: 7,
                subThemesData: const FlexSubThemesData(
                  blendOnLevel: 10,
                  blendOnColors: false,
                  useTextTheme: true,
                  useM2StyleDividerInM3: true,
                  alignedDropdown: true,
                  useInputDecoratorThemeInDialogs: true,
                ),
                visualDensity: FlexColorScheme.comfortablePlatformDensity,
                useMaterial3: true,
                swapLegacyOnMaterial3: true,
                // To use the Playground font, add GoogleFonts package and uncomment
                fontFamily:
                    (state.appSettings.local == const Language.initial(id: 1))
                        ? GoogleFonts.notoSans().fontFamily
                        : GoogleFonts.harmattan().fontFamily,
              ),
              darkTheme: FlexThemeData.dark(
                scheme: FlexScheme.purpleM3,
                surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
                blendLevel: 13,
                subThemesData: const FlexSubThemesData(
                  blendOnLevel: 20,
                  useTextTheme: true,
                  useM2StyleDividerInM3: true,
                  alignedDropdown: true,
                  useInputDecoratorThemeInDialogs: true,
                ),
                visualDensity: FlexColorScheme.comfortablePlatformDensity,
                useMaterial3: true,
                swapLegacyOnMaterial3: true,


                fontFamily:
                    (state.appSettings.local == const Language.initial(id: 1))
                        ? GoogleFonts.notoSans().fontFamily
                        : GoogleFonts.harmattan().fontFamily,
              ),
              themeMode:
                  state.appSettings.light ? ThemeMode.dark : ThemeMode.light,
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
