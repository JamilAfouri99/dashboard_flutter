import 'package:dashboard/configuration/constants.dart';
import 'package:dashboard/cubit/user/user_state.dart';
import 'package:dashboard/models/enums.dart';
import 'package:dashboard/navigation/router_manager.dart';
import 'package:dashboard/screens/user/user_screen.dart';
import 'package:dashboard/widgets/custom_progress_indicator.dart';
import 'package:dashboard/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dashboard/cubit/user/user_cubit.dart';
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
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context); // Close the dialog
                  },
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    _handleAction(context); // Handle the selected action
                  },
                  child: Text(buttonText),
                ),
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

  void _deleteContact(BuildContext context, UserCubit contactCubit) {
    if (user == null) return;
    contactCubit.deleteUser(user!.id.toString()).then((_) {
      Navigator.pop(context); // Close the dialog
      RouteManager.routerManagerPushUntil(
        context: context,
        routeName: RouteConstants.users,
      ); // Navigate to the home screen
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete contact: $error')),
      );
      Navigator.pop(context); // Close the dialog
    });
  }

  Future<void> _createUser(BuildContext context, UserCubit contactCubit) async {
    if (newUser == null) return;
    await contactCubit.createUser(newUser!);
    final state = contactCubit.state;
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
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(content: Text('Failed to add contact: $error')),
      // );
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
        : RouteManager.navigateToWithData(context, () => UserScreen(user: user));
  }
}
