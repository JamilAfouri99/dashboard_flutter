import 'package:dashboard/configuration/constants.dart';
import 'package:dashboard/cubit/contact/contact_state.dart';
import 'package:dashboard/models/contact.dart';
import 'package:dashboard/models/enums.dart';
import 'package:dashboard/navigation/router_manager.dart';
import 'package:dashboard/widgets/custom_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dashboard/cubit/contact/contact_cubit.dart';

class ConfirmationDialog extends StatelessWidget {
  final ConfirmationDialogAction action;
  final String? contactId;
  final Contact? contact;

  const ConfirmationDialog({
    super.key,
    required this.action,
    required this.contactId,
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
      case ConfirmationDialogAction.cancel:
        title = 'Confirm Cancel';
        message = 'Are you sure you want to cancel?';
        buttonText = 'Cancel';
        break;
    }

    return BlocConsumer<ContactCubit, ContactState>(
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
    final contactCubit = context.read<ContactCubit>();

    switch (action) {
      case ConfirmationDialogAction.delete:
        _deleteContact(context, contactCubit);
        break;
      case ConfirmationDialogAction.add:
        _addContact(context, contactCubit);
        break;
      case ConfirmationDialogAction.cancel:
        _cancelContact(context, contactCubit);
        break;
    }
  }

  void _deleteContact(BuildContext context, ContactCubit contactCubit) {
    if (contactId == null) return;
    contactCubit.deleteContact(contactId!).then((_) {
      Navigator.pop(context); // Close the dialog
      RouteManager.routerManagerPushUntil(
        context: context,
        routeName: RouteConstants.contacts,
      ); // Navigate to the home screen
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete contact: $error')),
      );
      Navigator.pop(context); // Close the dialog
    });
  }

  void _addContact(BuildContext context, ContactCubit contactCubit) {
    if (contact == null) return;
    contactCubit.addNewContact(contact!).then((_) {
      Navigator.pop(context);
      RouteManager.routerManagerPushUntil(
        context: context,
        routeName: RouteConstants.contacts,
      );
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to add contact: $error')),
      );
      Navigator.pop(context);
    });
  }

  void _cancelContact(BuildContext context, ContactCubit contactCubit) {
    Navigator.pop(context);
    RouteManager.routerManagerPushUntil(
      context: context,
      routeName: RouteConstants.contacts,
    );
  }
}
