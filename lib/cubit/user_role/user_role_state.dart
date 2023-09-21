import 'package:equatable/equatable.dart';
import 'package:qcarder_api/api.dart';

class UserRoleState extends Equatable {
  final AuthUserRoleEnum role;

  const UserRoleState(this.role);

  @override
  List<Object> get props => [role];
}
