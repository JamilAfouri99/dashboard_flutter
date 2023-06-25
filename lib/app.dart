import 'package:dashboard/configuration/config.dart';
import 'package:dashboard/cubit/auth/auth_cubit.dart';
import 'package:dashboard/configuration/theme.dart';
import 'package:dashboard/configuration/constants.dart';
import 'package:dashboard/cubit/user/user_cubit.dart';
import 'package:dashboard/cubit/users/users_cubit.dart';
import 'package:dashboard/services/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qcarder_api/api.dart';
import 'Navigation/router.dart' as router;
import 'package:openapi_generator_annotations/openapi_generator_annotations.dart';

@Openapi(
  additionalProperties: AdditionalProperties(pubName: 'qcarder_api', pubAuthor: 'QCarder'),
  inputSpecFile: 'https://api.qcarder.com/docs-json',
  generatorName: Generator.dart,
  outputDirectory: 'apis',
  overwriteExistingFiles: true,
  skipSpecValidation: true,
  alwaysRun: true,
)
class MyApp extends StatefulWidget {
  final Locale locale;
  final ApiClient apiClient;
  MyApp(this.locale, {super.key}) : apiClient = ApiClient(basePath: EnvConfig.instance.baseUrl);

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
        BlocProvider(create: (_) => AuthCubit(widget.apiClient)..checkAccessToken()),
        BlocProvider(create: (_) => UsersCubit()),
        BlocProvider(create: (_) => UserCubit()),
      ],
      child: MaterialApp(
        title: 'Dashboard',
        onGenerateRoute: router.Router.generateRoute,
        initialRoute: RouteConstants.splash,
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        navigatorKey: NavigationService.navigatorKey,
        scaffoldMessengerKey: NavigationService.snackbarKey,
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
            child: SafeArea(child: child!),
          );
        },
      ),
    );
  }
}
