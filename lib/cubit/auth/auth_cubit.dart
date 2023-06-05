import 'package:dashboard/cubit/auth/auth_state.dart';
import 'package:dashboard/configuration/constants.dart';
import 'package:dashboard/models/token.dart';
import 'package:dashboard/models/user.dart';
import 'package:dashboard/navigation/router_manager.dart';
import 'package:dashboard/repositories/token.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState> {
  final makeRepository = TokenRepository.make();
  TokenRepository? repository;

  AuthCubit() : super(UnknownAuthState());

  Future<void> checkToken() async {
    emit(AuthenticatingState());

    try {
      final repository = await makeRepository;
      final token = await repository.getToken();

      await Future.delayed(const Duration(seconds: 2));

      token != null ? emit(AuthenticatedState(token)) : emit(UnauthenticatedState());
    } catch (e) {
      emit(AuthenticationFailed(e));
    }
  }

  Future<void> login(String email, String password) async {
    emit(AuthenticatingState());

    try {
      await Future.delayed(const Duration(seconds: 2));

      final user = User(email: email, password: password);
      // call the endpoint
      final token = Token('foo');

      emit(AuthenticatedState(token));
      print('Authenticated');
    } catch (e) {
      emit(AuthenticationFailed(e));
    }
  }

  Future<void> signUp(String email, String password) async {
    emit(AuthenticatingState());

    try {
      await Future.delayed(const Duration(seconds: 2));
      final user = User(email: email, password: password);
      // call the endpoint
      final token = Token('foo');

      emit(AuthenticatedState(token));
    } catch (e) {
      emit(AuthenticationFailed(e));
    }
  }

  Future<void> logout(context) async {
    emit(UnknownAuthState());
    RouteManager().routerManagerPushUntil(routeName: RouteConstants.splash, context: context);

    await repository?.removeToken();
    repository = null;

    await Future.delayed(const Duration(seconds: 2));

    emit(UnauthenticatedState());
  }
}
