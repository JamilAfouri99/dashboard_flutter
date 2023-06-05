import 'package:dashboard/models/token.dart';

abstract class AuthState {}

class UnknownAuthState extends AuthState {}

class AuthenticatingState extends AuthState {}

class AuthenticatedState extends AuthState {
  final Token token;
  AuthenticatedState(this.token);
}

class UnauthenticatedState extends AuthState {}

class AuthenticationFailed extends AuthState {
  final Object reason;
  AuthenticationFailed(this.reason);
}
