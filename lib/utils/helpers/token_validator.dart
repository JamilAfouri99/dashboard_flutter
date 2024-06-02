import 'package:jwt_decoder/jwt_decoder.dart';

bool isTokenExpired(String token) {
  final decodedToken = JwtDecoder.decode(token);
  final expiryInSeconds = (decodedToken['exp'] as num).toInt();
  final nowInSeconds = DateTime.now().millisecondsSinceEpoch ~/ 1000;

  return expiryInSeconds < nowInSeconds;
}
