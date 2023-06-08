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
      final Token? token = await repository.getToken();

      await Future.delayed(const Duration(seconds: 2));

      token != null ? emit(AuthenticatedState(token)) : emit(UnauthenticatedState());
    } catch (e) {
      emit(AuthenticationFailed(e));
    }
  }

  Future<void> login(String email, String password) async {
    emit(AuthenticatingState());

    try {
      final response = await Future.delayed(const Duration(seconds: 2),
          () => {'user': User(email: email, password: password), 'token': 'foo'});

      final user = response['user'];
      print(user);
      final token = Token(response['token'].toString());

      repository = await makeRepository;
      await repository?.setToken(token);

      emit(AuthenticatedState(token));
    } catch (e) {
      emit(AuthenticationFailed(e));
    }
  }

  Future<void> signUp(String email, String password) async {
    emit(AuthenticatingState());

    try {
      await Future.delayed(const Duration(seconds: 2));
      final user = User(email: email, password: password);
      print(user);
      // call the endpoint
      final token = Token('foo');

      emit(AuthenticatedState(token));
    } catch (e) {
      emit(AuthenticationFailed(e));
    }
  }

  Future<void> logout(context) async {
    emit(UnknownAuthState());
    RouteManager.routerManagerPushUntil(routeName: RouteConstants.splash, context: context);

    repository = await makeRepository;
    await repository?.removeToken();
    repository = null;

    await Future.delayed(const Duration(seconds: 2));

    emit(UnauthenticatedState());
  }
}
