import 'package:dashboard/cubit/auth/auth_cubit.dart';
import 'package:dashboard/configuration/theme.dart';
import 'package:dashboard/configuration/constants.dart';
import 'package:dashboard/cubit/contact/contact_cubit.dart';
import 'package:dashboard/cubit/contacts/contacts_cubit.dart';
import 'package:dashboard/services/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'Navigation/router.dart' as router;

class MyApp extends StatefulWidget {
  final Locale locale;
  const MyApp(this.locale, {super.key});

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
        BlocProvider(create: (_) => AuthCubit()..checkToken()),
        BlocProvider(create: (_) => ContactsCubit()),
        BlocProvider(create: (_) => ContactCubit()),
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
