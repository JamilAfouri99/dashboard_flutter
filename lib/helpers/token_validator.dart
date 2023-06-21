import 'package:jwt_decoder/jwt_decoder.dart';

bool isTokenExpired(String token) {
  final decodedToken = JwtDecoder.decode(token);
  final expiry = decodedToken['exp'];
  final nowInSeconds = DateTime.now().millisecondsSinceEpoch ~/ 1000;
  return expiry < nowInSeconds;
}
