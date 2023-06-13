import 'package:dashboard/configuration/constants.dart';
import 'package:dashboard/cubit/user/user_state.dart';
import 'package:dashboard/models/contact.dart';
import 'package:dashboard/models/enums.dart';
import 'package:dashboard/navigation/router_manager.dart';
import 'package:dashboard/screens/user/user_screen.dart';
import 'package:dashboard/widgets/custom_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dashboard/cubit/user/user_cubit.dart';

class ConfirmationDialog extends StatelessWidget {
  final ConfirmationDialogAction action;
  final String? contactId;
  final DummyUser? contact;

  const ConfirmationDialog({
    super.key,
    this.contactId,
    required this.action,
    this.contact,
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
      builder: (context, state) => state is LoadingState
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
        _addContact(context, contactCubit);
        break;
      case ConfirmationDialogAction.update:
        _updateContact(context, contactCubit);
        break;
      case ConfirmationDialogAction.cancel:
        _cancelContact(context, contactCubit);
        break;
    }
  }

  void _deleteContact(BuildContext context, UserCubit contactCubit) {
    if (contactId == null) return;
    contactCubit.deleteUser(contactId!).then((_) {
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

  void _addContact(BuildContext context, UserCubit contactCubit) {
    if (contact == null) return;
    contactCubit.addNewUser(contact!).then((_) {
      Navigator.pop(context);
      RouteManager.routerManagerPushUntil(
        context: context,
        routeName: RouteConstants.users,
      );
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to add contact: $error')),
      );
      Navigator.pop(context);
    });
  }

  void _updateContact(BuildContext context, UserCubit contactCubit) {
    if (contact == null) return;
    contactCubit.updateUser(contact!).then((_) {
      Navigator.pop(context);
      RouteManager.navigateToWithData(
        context,
        () => UserScreen(user: contactCubit.contact),
      );
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to add contact: $error')),
      );
      Navigator.pop(context);
    });
  }

  void _cancelContact(BuildContext context, UserCubit contactCubit) {
    Navigator.pop(context);
    contact != null
        ? RouteManager.navigateToWithData(
            context,
            () => UserScreen(user: contact),
          )
        : RouteManager.routerManagerPushUntil(
            context: context,
            routeName: RouteConstants.users,
          );
  }
}
