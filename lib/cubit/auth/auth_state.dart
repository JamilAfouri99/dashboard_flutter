import 'package:qcarder/models/tokens.dart';

abstract class AuthState {}

class UnknownAuthState extends AuthState {}

class AuthenticatingState extends AuthState {}

class AuthenticatedState extends AuthState {
  final AccessToken accessToken;
  final RefreshToken refreshToken;

  AuthenticatedState({
    required this.accessToken,
    required this.refreshToken,
  });
}

class UnauthenticatedState extends AuthState {}

class AuthenticationFailed extends AuthState {
  final Object reason;
  AuthenticationFailed(this.reason);
}
