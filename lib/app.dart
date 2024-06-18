// Openapi Generator last run: : 2024-06-07T18:55:55.918831
import 'package:qcarder/cubit/auth/auth_cubit.dart';
import 'package:qcarder/cubit/banner/banner_cubit.dart';
import 'package:qcarder/utils/configuration/theme.dart';
import 'package:qcarder/utils/configuration/constants.dart';
import 'package:qcarder/cubit/avatar/avatar_cubit.dart';
import 'package:qcarder/cubit/user_role/user_role_cubit.dart';
import 'package:qcarder/cubit/theme/theme_cubit.dart';
import 'package:qcarder/cubit/theme/theme_state.dart';
import 'package:qcarder/cubit/user/user_cubit.dart';
import 'package:qcarder/cubit/users/users_cubit.dart';
import 'package:qcarder/services/global_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'utils/navigation/router.dart' as router;
import 'package:openapi_generator_annotations/openapi_generator_annotations.dart';

@Openapi(
  inputSpec: InputSpec(path: 'api_docs.yaml'),
  outputDirectory: 'apis',
  generatorName: Generator.dart,
  additionalProperties: AdditionalProperties(
    pubName: 'qcarder_api',
    pubAuthor: 'QCarder',
  ),
  skipSpecValidation: true,
)
class MyApp extends StatefulWidget {
  final Locale locale;
  // final ApiClient apiClient;
  MyApp(this.locale, {super.key});

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
        BlocProvider(create: (_) => UserRoleCubit()),
        BlocProvider(create: (_) => UsersCubit()),
        BlocProvider(create: (_) => UserCubit()),
        BlocProvider(create: (_) => AvatarCubit()),
        BlocProvider(create: (_) => BannerCubit()),
        BlocProvider(create: (_) => ThemeCubit()),
      ],
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) => MaterialApp(
          title: 'QCarder',
          onGenerateRoute: router.Router.generateRoute,
          initialRoute: RouteConstants.splash,
          debugShowCheckedModeBanner: false,
          theme: lightTheme,
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
