import 'package:qcarder/utils/models/tokens.dart';
import 'package:qcarder_api/api.dart';

abstract class AuthState {}

class UnknownAuthState extends AuthState {}

class AuthenticatingState extends AuthState {}

class AuthenticatedState extends AuthState {
  final AccessToken accessToken;
  final RefreshToken refreshToken;
  final AuthUser authUser;

  AuthenticatedState({
    required this.authUser,
    required this.accessToken,
    required this.refreshToken,
  });
}

class UnauthenticatedState extends AuthState {}

class AuthenticationFailed extends AuthState {
  final Object reason;
  AuthenticationFailed(this.reason);
}
