import 'package:qcarder/models/tokens.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TokensRepository {
  static Future<TokensRepository> make() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return TokensRepository(prefs);
  }

  final SharedPreferences tokensStorage;
  TokensRepository(this.tokensStorage);

  Future<AccessToken?> getAccessToken() async {
    final value = tokensStorage.getString('accessToken');
    if (value == null) {
      return null;
    }
    return AccessToken(value);
  }

  Future<RefreshToken?> getRefreshToken() async {
    final value = tokensStorage.getString('refreshToken');
    if (value == null) {
      return null;
    }
    return RefreshToken(value);
  }

  Future<void> setAccessToken(AccessToken accessToken) async {
    await tokensStorage.setString('accessToken', accessToken.token);
  }

  Future<void> setRefreshToken(RefreshToken refreshToken) async {
    await tokensStorage.setString('refreshToken', refreshToken.token);
  }

  Future<void> setTokens({
    required AccessToken accessToken,
    required RefreshToken refreshToken,
  }) async {
    await setAccessToken(accessToken);
    await setRefreshToken(refreshToken);
  }

  Future<void> removeTokens() async {
    await tokensStorage.clear();
  }
}
