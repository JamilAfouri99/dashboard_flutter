import 'package:qcarder/cubit/auth/auth_state.dart';
import 'package:qcarder/utils/configuration/constants.dart';
import 'package:qcarder/cubit/user_role/user_role_cubit.dart';
import 'package:qcarder/utils/models/tokens.dart';
import 'package:qcarder/utils/navigation/router_manager.dart';
import 'package:qcarder/utils/repositories/credentials.dart';
import 'package:qcarder/services/error/network_exceptions.dart';
import 'package:qcarder/services/http/remote_service.dart';
import 'package:qcarder/services/global_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qcarder_api/api.dart';

class AuthCubit extends Cubit<AuthState> {
  final makeRepository = Repository.make();
  final ApiClient apiClient = ClientService.apiClient;

  late AuthApi authApi;
  late Repository repository;
  late RemoteService remoteService;
  late UserRoleCubit userRoleCubit;
  bool rememberMe = false;

  AuthCubit() : super(UnknownAuthState()) {
    authApi = AuthApi(apiClient);
    remoteService = RemoteService();
    userRoleCubit = context.read<UserRoleCubit>();
  }

  // call in splash screen
  Future<void> checkAccessToken() async {
    repository = await makeRepository;

    if (await repository.getCredentials() != null) rememberMe = true;

    emit(AuthenticatingState());
    final result = await remoteService.asyncTryCatch(
      () => authApi.signinUsingAccessToken(),
    );

    if (!result.isError && result.value != null) {
      await repository.setTokens(
        accessToken: AccessToken(result.value!.accessToken),
        refreshToken: RefreshToken(result.value!.refreshToken),
      );

      final AuthUserRoleEnum userRole = result.value!.role;
      userRoleCubit.updateUserRole(userRole);

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

      final AuthUserRoleEnum userRole = result.value!.role;
      userRoleCubit.updateUserRole(userRole);

      emit(AuthenticatedState(
        authUser: result.value!,
        accessToken: AccessToken(result.value!.accessToken),
        refreshToken: RefreshToken(result.value!.refreshToken),
      ));

      // (save | remove) credentials
      if (rememberMe) {
        await repository.setCredentials(signInReq);
      } else {
        SigninDto? savedDate = await repository.getCredentials();
        if (savedDate != null) await repository.clearCredentials();
      }
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

      final AuthUserRoleEnum userRole = result.value!.role;
      userRoleCubit.updateUserRole(userRole);

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
    RouteManager.pushAndRemoveAll(
      routeName: RouteConstants.splash,
      context: context,
    );

    final result = await remoteService.asyncTryCatch(() => authApi.logout());
    await Future.delayed(const Duration(milliseconds: 500));

    await repository.clearTokens();
    if (!result.isError) emit(UnauthenticatedState());
    if (result.isError) {
      final error = NetworkExceptions.getHttpException(result.error);
      emit(AuthenticationFailed(error));
    }
  }

  Future<void> localLogout(context) async {
    emit(UnknownAuthState());
    RouteManager.pushAndRemoveAll(
      routeName: RouteConstants.splash,
      context: context,
    );

    await Future.delayed(const Duration(milliseconds: 500));
    await repository.clearTokens();

    emit(AuthenticationFailed(ErrorMessages.authenticationFailed));
  }

  Future<SigninDto?> getSavedCredentials() async {
    if (rememberMe) {
      return await repository.getCredentials();
    }
    return null;
  }
}
