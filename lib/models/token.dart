class Token {
  static const String tokenProperty = 'token';

  final String token;

  Token.emptyConstructor() : token = '';
  Token(this.token);

// deserializing
  factory Token.fromJson(Map<String, dynamic> json) => Token(
        json[tokenProperty],
      );

  // serialize
  Map<String, dynamic> toJson() => {tokenProperty: token};
}
