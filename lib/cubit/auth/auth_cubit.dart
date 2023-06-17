import 'package:dashboard/cubit/auth/auth_state.dart';
import 'package:dashboard/configuration/constants.dart';
import 'package:dashboard/models/sign_in.dart';
import 'package:dashboard/models/tokens.dart';
import 'package:dashboard/models/sign_up.dart';
import 'package:dashboard/models/logged_in_user.dart';
import 'package:dashboard/navigation/router_manager.dart';
import 'package:dashboard/repositories/token.dart';
import 'package:dashboard/services/api/auth_api.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState> {
  final makeRepository = TokensRepository.make();
  final AuthApi authApi;
  TokensRepository? repository;

  AuthCubit()
      : authApi = AuthApi(),
        super(UnknownAuthState());

  // call in splash screen
  Future<void> checkAccessToken() async {
    emit(AuthenticatingState());

    try {
      final repository = await makeRepository;
      final AccessToken? accessToken = await repository.getAccessToken();

      if (accessToken == null) {
        return checkRefreshToken();
      }

      LoggedInUser response = await authApi.accessToken();
      await repository.setTokens(
        accessToken: response.accessToken,
        refreshToken: response.refreshToken,
      );

      emit(AuthenticatedState(
        accessToken: response.accessToken,
        refreshToken: response.refreshToken,
      ));
    } catch (e) {
      emit(AuthenticationFailed(e));
    }
  }

  // call when I got 401 to generate new tokens (access - refresh)
  Future<void> checkRefreshToken() async {
    emit(AuthenticatingState());

    try {
      final repository = await makeRepository;
      final RefreshToken? refreshToken = await repository.getRefreshToken();

      if (refreshToken == null) {
        emit(UnauthenticatedState());
        // logout(context); //FIXME: complete this part
        return;
      }

      LoggedInUser response = await authApi.accessToken();
      await repository.setTokens(
        accessToken: response.accessToken,
        refreshToken: response.refreshToken,
      );

      AuthenticatedState(
        accessToken: response.accessToken,
        refreshToken: response.refreshToken,
      );
    } catch (e) {
      emit(AuthenticationFailed(e));
    }
  }

  Future<void> signIn(String email, String password) async {
    emit(AuthenticatingState());

    try {
      final response = await authApi.signIn(SignIn(email: email, password: password));

      repository = await makeRepository;
      await repository?.setTokens(
        accessToken: response.accessToken,
        refreshToken: response.refreshToken,
      );

      //TODO: store the user information

      emit(AuthenticatedState(
        accessToken: response.accessToken,
        refreshToken: response.refreshToken,
      ));
    } catch (e) {
      emit(AuthenticationFailed(e));
    }
  }

  Future<void> signUp(String email, String password) async {
    emit(AuthenticatingState());

    try {
      final response = await authApi.signUp(SignUp(email: email, password: password));

      repository = await makeRepository;
      await repository?.setTokens(
        accessToken: response.accessToken,
        refreshToken: response.refreshToken,
      );

      //TODO: store the user information

      emit(AuthenticatedState(
        accessToken: response.accessToken,
        refreshToken: response.refreshToken,
      ));
    } catch (e) {
      emit(AuthenticationFailed(e));
    }
  }

  Future<void> logout(context) async {
    emit(UnknownAuthState());
    RouteManager.routerManagerPushUntil(routeName: RouteConstants.splash, context: context);

    repository = await makeRepository;
    await repository?.removeTokens();
    repository = null;

    await authApi.logout();

    emit(UnauthenticatedState());
  }

  Future<void> remoteLogout(context) async {
    emit(UnknownAuthState());
    RouteManager.routerManagerPushUntil(routeName: RouteConstants.splash, context: context);

    repository = await makeRepository;
    await repository?.removeTokens();
    repository = null;
    // call the endpoint

    await Future.delayed(const Duration(seconds: 2));

    emit(UnauthenticatedState());
  }
}
