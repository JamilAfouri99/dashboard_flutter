class RouteConstants {
  static const String splash = '/';
  static const String home = '/home';
  static const String login = '/login';
  static const String signUp = '/signUp';
  static const String users = '/users';
  static String viewUser(String userId) => '/users/$userId';
  static const String user = '/user';
  static const String nfc = '/nfc';
}

class ApiConstants {
  static const String signUp = '/auth/signup';
  static const String signIn = '/auth/signin';
  static const String accessToken = '/auth/signin/access-token';
  static const String refreshToken = '/auth/signin/refresh-token';
  static const String users = '/users';
  static Function(String id) get user => (id) => '/users/$id';
  static const String logout = '/auth/logout';
}

class KeyConstants {
  static const String languageCode = 'Language Code';
  static const String countryCode = 'Country Code';
}
