import 'package:jwt_decoder/jwt_decoder.dart';

bool isTokenExpired(String token) {
  final decodedToken = JwtDecoder.decode(token);
  final expiry = decodedToken['exp'];
  final now = DateTime.now().millisecond;

  return expiry < now;
}
