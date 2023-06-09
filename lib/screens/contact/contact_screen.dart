import 'package:dashboard/configuration/theme.dart';
import 'package:dashboard/cubit/contact/contact_cubit.dart';
import 'package:dashboard/cubit/contact/contact_state.dart';
import 'package:dashboard/models/contact.dart';
import 'package:dashboard/screens/contact/editable_form.dart';
import 'package:dashboard/screens/contact/view_form.dart';
import 'package:dashboard/widgets/custom_progress_indicator.dart';
import 'package:dashboard/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContactScreen extends StatelessWidget {
  final Contact? contact;

  const ContactScreen({super.key, this.contact});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ContactCubit>(
      create: (context) {
        if (contact != null) return ContactCubit()..fetch(contact!.id);
        return ContactCubit();
      },
      child: SafeArea(
        child: BlocConsumer<ContactCubit, ContactState>(listener: (context, state) {
          if (state is FailedState) {
            CustomSnackbar.show(context, state.reason.toString());
          }
        }, builder: (context, state) {
          final isEditable = context.read<ContactCubit>().isEditable;
          return Scaffold(
            backgroundColor: AppColors.light,
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                contact == null
                    ? 'New Contact'
                    : isEditable
                        ? 'Update Contact'
                        : 'Profile',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            floatingActionButton:
                contact != null && !isEditable ? _floatingActionButton(context) : null,
            floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
            body: state is LoadingState
                ? const Center(child: CustomProgressIndicator())
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        isEditable || contact == null
                            ? EditableForm(contact: contact)
                            : ViewForm(contact: contact!),
                      ],
                    ),
                  ),
          );
        }),
      ),
    );
  }

  FloatingActionButton _floatingActionButton(BuildContext context) {
    final ContactCubit bloc = context.read<ContactCubit>();
    return FloatingActionButton(
      backgroundColor: AppColors.primary,
      onPressed: () => bloc.isEditableHandler(true),
      tooltip: 'Edit',
      child: const Icon(Icons.edit),
    );
  }
}
