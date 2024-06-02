import 'package:qcarder/utils/configuration/constants.dart';
import 'package:qcarder/utils/configuration/theme.dart';
import 'package:qcarder/cubit/avatar/avatar_cubit.dart';
import 'package:qcarder/cubit/avatar/avatar_state.dart';
import 'package:qcarder/cubit/user/user_state.dart';
import 'package:qcarder/utils/models/enums.dart';
import 'package:qcarder/utils/navigation/router_manager.dart';
import 'package:qcarder/screens/user/user_screen.dart';
import 'package:qcarder/services/http/remote_service.dart';
import 'package:qcarder/widgets/custom_progress_indicator.dart';
import 'package:qcarder/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qcarder/cubit/user/user_cubit.dart';
import 'package:qcarder_api/api.dart';
import 'package:http/http.dart' as http;

class ConfirmationDialog extends StatelessWidget {
  final ConfirmationDialogAction action;
  final String? userId;
  final User? updatedUser;
  final PostUserDto? newUser;
  final PatchUserProfileDto? updateProfile;
  final http.MultipartFile? avatar;

  const ConfirmationDialog({
    super.key,
    required this.action,
    this.userId,
    this.updatedUser,
    this.newUser,
    this.updateProfile,
    this.avatar,
  });

  @override
  Widget build(BuildContext context) {
    String title = '';
    String message = '';
    String buttonText = '';

    switch (action) {
      case ConfirmationDialogAction.delete:
        title = 'Confirm Delete';
        message = 'Are you sure you want to delete this contact?';
        buttonText = 'Delete';
        break;
      case ConfirmationDialogAction.add:
        title = 'Confirm Add';
        message = 'Are you sure you want to add this contact?';
        buttonText = 'Add';
        break;
      case ConfirmationDialogAction.update:
        title = 'Confirm Update';
        message = 'Are you sure you want to update this contact?';
        buttonText = 'Update';
        break;
      case ConfirmationDialogAction.cancel:
        title = 'Confirm Cancel';
        message = 'Are you sure you want to cancel?';
        buttonText = 'Confirm';
        break;
    }

    return BlocConsumer<UserCubit, UserState>(
      listener: (_, state) {},
      builder: (context, state) => state is UserLoading ||
              context.read<AvatarCubit>().state is AvatarLoading
          ? const CustomProgressIndicator()
          : AlertDialog(
              title: Text(title),
              content: Text(message),
              actionsPadding: const EdgeInsets.only(bottom: 20, right: 20),
              actions: [
                Wrap(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        gradient: const LinearGradient(
                          colors: [Color(0xffF3F6FC), Color(0xffF3F6FC)],
                        ),
                      ),
                      child: TextButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          alignment: Alignment.center,
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                        ),
                        onPressed: () {
                          Navigator.pop(context); // Close the dialog
                        },
                        child: const Text('Cancel'),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      // margin: const EdgeInsets.symmetric(vertical: 8.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        gradient: LinearGradient(
                          colors: [AppColors.primary, AppColors.primary.withOpacity(0.6)],
                          begin: Alignment.centerRight,
                          end: Alignment.centerLeft,
                        ),
                      ),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          alignment: Alignment.center,
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                        ),
                        onPressed: () {
                          _handleAction(context); // Handle the selected action
                        },
                        child: Text(buttonText),
                      ),
                    ),
                  ],
                )
              ],
            ),
    );
  }

  void _handleAction(BuildContext context) {
    final contactCubit = context.read<UserCubit>();

    switch (action) {
      case ConfirmationDialogAction.delete:
        _deleteContact(context, contactCubit);
        break;
      case ConfirmationDialogAction.add:
        _createUser(context, contactCubit);
        break;
      case ConfirmationDialogAction.update:
        _updateProfile(context, contactCubit);
        break;
      case ConfirmationDialogAction.cancel:
        _cancelContact(context);
        break;
    }
  }

  Future<void> _deleteContact(BuildContext context, UserCubit userCubit) async {
    if (userId == null) return;
    await userCubit.deleteUser(userId!);
    final state = userCubit.state;
    if (context.mounted) {
      if (state is UserFailed) {
        CustomSnackbar.show(
          context,
          'Failed to delete user: ${state.reason}',
          type: SnackbarType.error,
        );
        Navigator.pop(context);
      } else if (state is UserLoaded) {
        Navigator.pop(context);
        CustomSnackbar.show(
          context,
          'Deleted user successfully',
          type: SnackbarType.success,
        );
        RouteManager.pushAndRemoveAll(
          context: context,
          routeName: RouteConstants.users,
        );
      }
    }
  }

  Future<void> _createUser(BuildContext context, UserCubit contactCubit) async {
    if (newUser == null) return;
    await contactCubit.createUser(newUser!);
    final state = contactCubit.state;
    if (context.mounted) {
      if (state is UserFailed) {
        CustomSnackbar.show(
          context,
          'Failed to add contact: ${state.reason}',
          type: SnackbarType.error,
        );
        Navigator.pop(context);
      } else if (state is UserLoaded) {
        // Avatar uploading.
        if (avatar != null) {
          AvatarCubit avatarCubit = context.read<AvatarCubit>();
          final uploadingAvatar = await RemoteService().asyncTryCatch(
            () => avatarCubit.uploadAvatar(state.user!.id, avatar!),
          );
          if (uploadingAvatar.isError || avatarCubit.state is AvatarFailed) {
            if (context.mounted) {
              CustomSnackbar.show(
                context,
                'The user was successfully created, but the image failed to upload',
                type: SnackbarType.info,
              );
            }
          }
        }
        if (context.mounted) {
          Navigator.pop(context);
          RouteManager.pushAndRemoveAll(
            context: context,
            routeName: RouteConstants.users,
          );
        }
      }
    }
  }

  void _updateProfile(BuildContext context, UserCubit userCubit) {
    if (updatedUser == null || updateProfile == null) return;
    userCubit.updateProfile(updatedUser!, updateProfile!).then((_) {
      UserState state = userCubit.state;
      if (state is UserLoaded) {
        Navigator.pop(context);
        RouteManager.pushAndRemoveCurrentWithData(
          context,
          () => UserScreen(userId: updatedUser!.id),
        );
      } else if (state is UserFailed) {
        throw state.reason;
      }
    }).catchError((error) {
      CustomSnackbar.show(
        context,
        'Failed to add contact: $error',
        type: SnackbarType.error,
      );
      Navigator.pop(context);
    });
  }

  void _cancelContact(BuildContext context) {
    Navigator.pop(context);
    context.read<UserCubit>().isNewForm();
    userId == null
        ? RouteManager.pushAndRemoveAll(
            context: context,
            routeName: RouteConstants.users,
          )
        : RouteManager.pushAndRemoveCurrentWithData(
            context,
            () => UserScreen(userId: userId),
          );
  }
}
