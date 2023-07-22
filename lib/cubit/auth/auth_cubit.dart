import 'package:qcarder/cubit/auth/auth_state.dart';
import 'package:qcarder/configuration/constants.dart';
import 'package:qcarder/models/tokens.dart';
import 'package:qcarder/navigation/router_manager.dart';
import 'package:qcarder/repositories/token.dart';
import 'package:qcarder/services/error/network_exceptions.dart';
import 'package:qcarder/services/http/remote_service.dart';
import 'package:qcarder/services/global_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qcarder_api/api.dart';

class AuthCubit extends Cubit<AuthState> {
  final makeRepository = TokensRepository.make();
  final ApiClient apiClient = ClientService.apiClient;

  late AuthApi authApi;
  late TokensRepository repository;
  late RemoteService remoteService;

  AuthCubit() : super(UnknownAuthState()) {
    authApi = AuthApi(apiClient);
    remoteService = RemoteService();
  }

  // call in splash screen
  Future<void> checkAccessToken() async {
    repository = await makeRepository;

    emit(AuthenticatingState());
    final result = await remoteService.asyncTryCatch(
      () => authApi.signinUsingAccessToken(),
    );

    if (!result.isError && result.value != null) {
      await repository.setTokens(
        accessToken: AccessToken(result.value!.accessToken),
        refreshToken: RefreshToken(result.value!.refreshToken),
      );

      emit(AuthenticatedState(
        authUser: result.value!,
        accessToken: AccessToken(result.value!.accessToken),
        refreshToken: RefreshToken(result.value!.refreshToken),
      ));
    }

    if (result.isError || result.value == null) {
      emit(AuthenticationFailed(result.error));
    }
  }

  Future<void> signIn(SigninDto signInReq) async {
    emit(AuthenticatingState());

    final result = await remoteService.asyncTryCatch(
      () => authApi.signin(signInReq),
      isAccessToken: false,
    );

    if (result.isSuccess && result.value != null) {
      await repository.setTokens(
        accessToken: AccessToken(result.value!.accessToken),
        refreshToken: RefreshToken(result.value!.refreshToken),
      );

      emit(AuthenticatedState(
        authUser: result.value!,
        accessToken: AccessToken(result.value!.accessToken),
        refreshToken: RefreshToken(result.value!.refreshToken),
      ));
    }

    if (result.isError || result.value == null) {
      emit(AuthenticationFailed(result.error));
    }
  }

  Future<void> signUp(SignupDto signupReq) async {
    emit(AuthenticatingState());

    final result = await remoteService.asyncTryCatch(
      () => authApi.signup(signupReq),
      isAccessToken: false,
    );

    if (result.isSuccess && result.value != null) {
      await repository.setTokens(
        accessToken: AccessToken(result.value!.accessToken),
        refreshToken: RefreshToken(result.value!.refreshToken),
      );

      emit(AuthenticatedState(
        authUser: result.value!,
        accessToken: AccessToken(result.value!.accessToken),
        refreshToken: RefreshToken(result.value!.refreshToken),
      ));
    }

    if (result.isError || result.value == null) {
      emit(AuthenticationFailed(result.error));
    }
  }

  Future<void> remoteLogout(context) async {
    emit(UnknownAuthState());
    RouteManager.routerManagerPushUntil(
      routeName: RouteConstants.splash,
      context: context,
    );

    final result = await remoteService.asyncTryCatch(() => authApi.logout());
    await Future.delayed(const Duration(milliseconds: 500));

    await repository.removeTokens();
    if (!result.isError) emit(UnauthenticatedState());
    if (result.isError) {
      final error = NetworkExceptions.getHttpException(result.error);
      emit(AuthenticationFailed(error));
    }
  }

  Future<void> localLogout(context) async {
    emit(UnknownAuthState());
    RouteManager.routerManagerPushUntil(
      routeName: RouteConstants.splash,
      context: context,
    );

    await Future.delayed(const Duration(milliseconds: 500));
    await repository.removeTokens();

    emit(AuthenticationFailed(ErrorMessages.authenticationFailed));
  }
}
