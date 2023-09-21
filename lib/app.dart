// Openapi Generator last run: : 2023-09-21T03:57:33.953632
import 'package:qcarder/cubit/auth/auth_cubit.dart';
import 'package:qcarder/configuration/theme.dart';
import 'package:qcarder/configuration/constants.dart';
import 'package:qcarder/cubit/avatar/avatar_cubit.dart';
import 'package:qcarder/cubit/theme/theme_cubit.dart';
import 'package:qcarder/cubit/theme/theme_state.dart';
import 'package:qcarder/cubit/user/user_cubit.dart';
import 'package:qcarder/cubit/users/users_cubit.dart';
import 'package:qcarder/services/global_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qcarder_api/api.dart';
import 'Navigation/router.dart' as router;
import 'package:openapi_generator_annotations/openapi_generator_annotations.dart';

@Openapi(
  additionalProperties: AdditionalProperties(
    pubName: 'qcarder_api',
    pubAuthor: 'QCarder',
  ),
  inputSpecFile: 'api_docs.yaml',
  generatorName: Generator.dart,
  outputDirectory: 'apis',
  fetchDependencies: true,
  overwriteExistingFiles: false,
  alwaysRun: true,
  useNextGen: true,
)
class MyApp extends StatefulWidget {
  final Locale locale;
  final ApiClient apiClient;
  MyApp(this.locale, {super.key}) : apiClient = ClientService.apiClient;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AuthCubit()..checkAccessToken()),
        BlocProvider(create: (_) => UsersCubit()),
        BlocProvider(create: (_) => UserCubit()),
        BlocProvider(create: (_) => AvatarCubit()),
        BlocProvider(create: (_) => ThemeCubit()),
      ],
      child: BlocConsumer<ThemeCubit, ThemeState>(
        listener: (context, state) => {},
        builder: (context, state) => MaterialApp(
          title: 'QCarder',
          onGenerateRoute: router.Router.generateRoute,
          initialRoute: RouteConstants.splash,
          debugShowCheckedModeBanner: false,
          theme: lightTheme,
          // TODO: implement the theme
          // darkTheme: darkTheme,
          // themeMode: state.themeMode,
          navigatorKey: KeysService.navigatorKey,
          scaffoldMessengerKey: KeysService.snackbarKey,
          supportedLocales: const [
            Locale('en', ''), // English, no country code
            Locale('ar', ''), // Arabic, no country code
          ],
          locale: const Locale('en', ''),
          // set the max scale factor of all text in the app to 1.0 to avoid any issues.
          builder: (context, child) {
            final MediaQueryData data = MediaQuery.of(context);
            return MediaQuery(
              data: data.copyWith(textScaleFactor: 1.0),
              child: child!,
            );
          },
        ),
      ),
    );
  }
}