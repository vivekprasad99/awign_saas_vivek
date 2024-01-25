import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'core/config/cubit/flavor_cubit.dart';
import 'core/config/flavor_config.dart';
import 'core/data/local/database/hive_helper.dart';
import 'core/data/network/firebase/push_notification/firebase_messaging_service.dart';
import 'core/data/network/firebase/remote_config/remote_config_helper.dart';
import 'core/di/app_injection_container.dart' as app_injection_container;
import 'core/data/network/client/rest_client.dart' as rest_client;
import 'core/di/app_injection_container.dart';
import 'core/intl/strings.dart';
import 'core/router/my_global_route_observer.dart';
import 'core/router/router.dart';
import 'core/widget/network_sensitive/cubit/internet_cubit.dart';
import 'core/widget/theme/cubit/theme_cubit.dart';
import 'core/widget/theme/theme_manager.dart';
import 'firebase_options.dart';

void mainCommon(FlavorConfig flavorConfig) async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  if (kDebugMode) {
    /// Force disable Crashlytics collection while doing every day development.
    /// Temporarily toggle this to true if you want to test crash reporting in your app.
    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(false);
  }
  /// Pass all uncaught "fatal" errors from the framework to Crashlytics
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  /// Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };
  RemoteConfigHelper.instance();
  app_injection_container.init();
  rest_client.init(flavorConfig);
  await HiveHelper.hiveInit();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<FlavorCubit>(
        create: (_) => FlavorCubit(flavorConfig),
      ),
      BlocProvider<InternetCubit>(
        create: (_) => InternetCubit(sl<Connectivity>()),
      ),
      BlocProvider<ThemeCubit>(
        create: (_) => ThemeCubit(),
      ),
    ],
    child: const AwignApp(),
  ));
}

class AwignApp extends StatefulWidget {
  const AwignApp({Key? key}) : super(key: key);

  @override
  _AwignAppState createState() => _AwignAppState();
}

class _AwignAppState extends State<AwignApp> with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    FirebaseMessagingService().requestAndRegisterNotification();
    super.initState();
  }

  @override
  void didChangePlatformBrightness() {
    context.read<ThemeCubit>().updateAppTheme();
    super.didChangePlatformBrightness();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    FlavorCubit flavorCubit = context.read<FlavorCubit>();
    return DynamicColorBuilder(
      builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
        ColorScheme lightScheme;
        ColorScheme darkScheme;
        CustomColors lightCustomColors;
        CustomColors darkCustomColors;

        if (lightDynamic != null && darkDynamic != null) {
          lightScheme = lightDynamic.harmonized();
          lightCustomColors =
              AppColors.lightCustomColors.harmonized(lightScheme);

          /// Repeat for the dark color scheme.
          darkScheme = darkDynamic.harmonized();
          darkCustomColors = AppColors.darkCustomColors.harmonized(darkScheme);
        } else {
          /// Otherwise, use fallback schemes.
          lightScheme = AppColors.lightColorScheme;
          darkScheme = AppColors.darkColorScheme;
        }

        return GetMaterialApp(
          title: flavorCubit.flavorConfig.appName,
          debugShowCheckedModeBanner:
              flavorCubit.flavorConfig.appFlavor != AppFlavor.production
                  ? true
                  : false,
          theme: ThemeData(
            useMaterial3: true,
            colorScheme: AppColors.lightColorScheme,
            textTheme: AppTextThemes.textThemeLight,
            fontFamily: 'inter',
            extensions: const [AppColors.lightCustomColors],
          ),
          darkTheme: ThemeData(
            useMaterial3: true,
            colorScheme: AppColors.darkColorScheme,
            textTheme: AppTextThemes.textThemeDark,
            fontFamily: 'inter',
            extensions: const [AppColors.darkCustomColors],
          ),
          themeMode: ThemeMode.light,
          translations: Strings(),
          locale: const Locale('en', ''),
          supportedLocales: const [Locale('en', ''), Locale('hi', '')],
          onGenerateRoute: sl<MRouter>().onGenerateRoute,
          initialRoute: MRouter.splashRoute,
          navigatorKey: MRouter.globalNavigatorKey,
          navigatorObservers: [MyGlobalRouteObserver()],
        );
      },
    );
  }
}
