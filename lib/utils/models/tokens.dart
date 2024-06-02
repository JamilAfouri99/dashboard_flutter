class AccessToken {
  static const String accessTokenProperty = 'access_token';

  final String token;

  AccessToken(this.token);
  AccessToken.emptyConstructor() : token = '';

  // Deserializing from JSON
  factory AccessToken.fromJson(Map<String, dynamic> json) {
    return AccessToken(json[accessTokenProperty] as String);
  }

  // Serializing to JSON
  Map<String, dynamic> toJson() => {
        accessTokenProperty: token,
      };
}

class RefreshToken {
  static const String refreshTokenProperty = 'refresh_token';

  final String token;

  RefreshToken(this.token);
  RefreshToken.emptyConstructor() : token = '';

  // Deserializing from JSON
  factory RefreshToken.fromJson(Map<String, dynamic> json) {
    return RefreshToken(json[refreshTokenProperty] as String);
  }

  // Serializing to JSON
  Map<String, dynamic> toJson() => {
        refreshTokenProperty: token,
      };
}

class Tokens {
  static const String accessTokenProperty = 'access_token';
  static const String refreshTokenProperty = 'refresh_token';

  final String accessToken;
  final String refreshToken;

  Tokens({
    required this.accessToken,
    required this.refreshToken,
  });

  // Empty constructor

  // Deserializing from JSON
  factory Tokens.fromJson(Map<String, dynamic> json) {
    return Tokens(
      accessToken: json[accessTokenProperty] as String,
      refreshToken: json[refreshTokenProperty] as String,
    );
  }

  // Serializing to JSON
  Map<String, dynamic> toJson() => {
        accessTokenProperty: accessToken,
        refreshTokenProperty: refreshToken,
      };
}
