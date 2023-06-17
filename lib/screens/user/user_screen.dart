import 'package:dashboard/configuration/theme.dart';
import 'package:dashboard/cubit/user/user_cubit.dart';
import 'package:dashboard/cubit/user/user_state.dart';
import 'package:dashboard/models/contact.dart';
import 'package:dashboard/screens/user/editable_form.dart';
import 'package:dashboard/screens/user/view_form.dart';
import 'package:dashboard/widgets/custom_progress_indicator.dart';
import 'package:dashboard/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserScreen extends StatelessWidget {
  final DummyUser? user;

  const UserScreen({super.key, this.user});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserCubit>(
      create: (context) {
        if (user != null) return UserCubit()..fetch(user!.id);
        return UserCubit();
      },
      child: BlocConsumer<UserCubit, UserState>(listener: (context, state) {
        if (state is UserFailed) {
          CustomSnackbar.show(context, state.reason.toString());
        }
      }, builder: (context, state) {
        final isEditable = context.read<UserCubit>().isEditable;
        return Scaffold(
          backgroundColor: AppColors.light,
          appBar: AppBar(
            automaticallyImplyLeading: isEditable || user == null ? false : true,
            centerTitle: true,
            title: Text(
              user == null
                  ? 'New Contact'
                  : isEditable
                      ? 'Update Contact'
                      : 'Profile',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          floatingActionButton: user != null && !isEditable && state is! UserLoading
              ? _floatingActionButton(context)
              : null,
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          body: state is UserLoading
              ? const Center(child: CustomProgressIndicator())
              : RefreshIndicator(
                  onRefresh: () {
                    if (user != null) return context.read<UserCubit>().fetch(user!.id);
                    return Future(() => null);
                  },
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        isEditable || user == null
                            ? EditableForm(contact: user)
                            : ViewForm(contact: user!),
                      ],
                    ),
                  ),
                ),
        );
      }),
    );
  }

  FloatingActionButton _floatingActionButton(BuildContext context) {
    final UserCubit bloc = context.read<UserCubit>();
    return FloatingActionButton(
      backgroundColor: AppColors.primary,
      onPressed: () => bloc.isEditableHandler(true),
      tooltip: 'Edit',
      child: const Icon(Icons.edit),
    );
  }
}
