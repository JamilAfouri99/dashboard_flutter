import 'package:qcarder_api/api.dart';

class RoleChecker {
  static final Set<AuthUserRoleEnum> allowedRoles = {
    AuthUserRoleEnum.SUPERADMIN,
    AuthUserRoleEnum.ADMIN,
  };

  static bool canAccessUsersScreen(AuthUserRoleEnum userRole) {
    return allowedRoles.contains(userRole);
  }
}
