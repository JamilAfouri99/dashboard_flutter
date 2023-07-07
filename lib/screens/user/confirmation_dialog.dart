import 'package:qcarder/configuration/constants.dart';
import 'package:qcarder/cubit/user/user_state.dart';
import 'package:qcarder/models/enums.dart';
import 'package:qcarder/navigation/router_manager.dart';
import 'package:qcarder/screens/user/user_screen.dart';
import 'package:qcarder/widgets/custom_button.dart';
import 'package:qcarder/widgets/custom_progress_indicator.dart';
import 'package:qcarder/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qcarder/cubit/user/user_cubit.dart';
import 'package:qcarder_api/api.dart';

class ConfirmationDialog extends StatelessWidget {
  final ConfirmationDialogAction action;
  final User? user;
  final PostUserDto? newUser;
  final PatchUserProfileDto? updateProfile;

  const ConfirmationDialog({
    super.key,
    required this.action,
    this.user,
    this.newUser,
    this.updateProfile,
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
      builder: (context, state) => state is UserLoading
          ? const CustomProgressIndicator()
          : AlertDialog(
              title: Text(title),
              content: Text(message),
              actionsPadding: const EdgeInsets.only(bottom: 20, right: 20),
              actions: [
                Wrap(
                  children: [
                    SizedBox(
                      height: 50,
                      width: 120,
                      child: CustomButton(
                        title: 'Cancel',
                        isInverted: true,
                        onPressed: () {
                          Navigator.pop(context); // Close the dialog
                        },
                      ),
                    ),
                    const SizedBox(width: 10),
                    SizedBox(
                      height: 50,
                      width: 120,
                      child: CustomButton(
                        title: buttonText,
                        onPressed: () {
                          _handleAction(context); // Handle the selected action
                        },
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
    if (user == null) return;
    await userCubit.deleteUser(user!.id);
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
        RouteManager.routerManagerPushUntil(
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
        Navigator.pop(context);
        RouteManager.routerManagerPushUntil(
          context: context,
          routeName: RouteConstants.users,
        );
      }
    }
  }

  void _updateProfile(BuildContext context, UserCubit userCubit) {
    if (user == null || updateProfile == null) return;
    userCubit.updateProfile(user!, updateProfile!).then((_) {
      UserState state = userCubit.state;
      if (state is UserLoaded) {
        Navigator.pop(context);
        RouteManager.navigateToWithData(
          context,
          () => UserScreen(user: state.user),
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
    user == null
        ? RouteManager.routerManagerPushUntil(
            context: context,
            routeName: RouteConstants.users,
          )
        : RouteManager.pushAndRemovePrevUntilWithData(
            context,
            () => UserScreen(user: user),
          );
  }
}
