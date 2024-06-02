import 'package:qcarder/utils/models/tokens.dart';
import 'package:qcarder_api/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Repository {
  static Future<Repository> make() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return Repository(prefs);
  }

  final SharedPreferences storage;
  Repository(this.storage);

  // TOKENS
  Future<AccessToken?> getAccessToken() async {
    final value = storage.getString('accessToken');
    if (value == null) {
      return null;
    }
    return AccessToken(value);
  }

  Future<RefreshToken?> getRefreshToken() async {
    final value = storage.getString('refreshToken');
    if (value == null) {
      return null;
    }
    return RefreshToken(value);
  }

  Future<void> setAccessToken(AccessToken accessToken) async {
    await storage.setString('accessToken', accessToken.token);
  }

  Future<void> setRefreshToken(RefreshToken refreshToken) async {
    await storage.setString('refreshToken', refreshToken.token);
  }

  Future<void> setTokens({
    required AccessToken accessToken,
    required RefreshToken refreshToken,
  }) async {
    await setAccessToken(accessToken);
    await setRefreshToken(refreshToken);
  }

  Future<void> clearTokens() async {
    final keysToRemove = ['accessToken', 'refreshToken'];
    for (final key in keysToRemove) {
      await storage.remove(key);
    }
  }

  // CREDENTIALS
  Future<void> setCredentials(SigninDto data) async {
    await storage.setString('email', data.email);
    await storage.setString('password', data.password);
  }

  Future<SigninDto?> getCredentials() async {
    final email = storage.getString('email');
    final password = storage.getString('password');

    if (email == null || password == null) return null;

    return SigninDto(email: email, password: password);
  }

  Future<void> clearCredentials() async {
    final keysToRemove = ['email', 'password'];
    for (final key in keysToRemove) {
      await storage.remove(key);
    }
  }

  Future<void> clearStorage() async {
    await storage.clear();
  }
}
