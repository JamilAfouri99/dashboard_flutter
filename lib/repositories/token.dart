import 'package:dashboard/models/token.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TokenRepository {
  static Future<TokenRepository> make() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return TokenRepository(prefs);
  }

  final SharedPreferences tokenStorage;
  TokenRepository(this.tokenStorage);

  Future<Token?> getToken() async {
    final value = tokenStorage.getString('token');
    if (value == null) {
      return null;
    }
    return Token(value);
  }

  Future<void> setToken(Token token) async {
    await tokenStorage.setString('token', token.token);
  }

  Future<void> removeToken() async {
    if (tokenStorage.containsKey('token')) {
      await tokenStorage.clear();
    }
  }
}
