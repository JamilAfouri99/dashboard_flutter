import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qcarder/cubit/user_role/user_role_state.dart';
import 'package:qcarder_api/api.dart';

class UserRoleCubit extends Cubit<UserRoleState> {
  UserRoleCubit() : super(const UserRoleState(AuthUserRoleEnum.USER));

  void updateUserRole(AuthUserRoleEnum role) {
    emit(UserRoleState(role));
  }
}
