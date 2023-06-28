import 'package:dashboard/configuration/constants.dart';
import 'package:dashboard/configuration/theme.dart';
import 'package:dashboard/cubit/user/user_cubit.dart';
import 'package:dashboard/cubit/user/user_state.dart';
import 'package:dashboard/navigation/router_manager.dart';
import 'package:dashboard/screens/user/editable_form.dart';
import 'package:dashboard/screens/user/new_form.dart';
import 'package:dashboard/screens/user/view_form.dart';
import 'package:dashboard/widgets/custom_progress_indicator.dart';
import 'package:dashboard/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qcarder_api/api.dart';

class UserScreen extends StatelessWidget {
  final User? user;

  const UserScreen({super.key, this.user});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserCubit>(
      create: (_) {
        if (user != null) return UserCubit()..getUserById(user!.id);
        return UserCubit();
      },
      child: BlocConsumer<UserCubit, UserState>(
        listener: (context, state) {
          if (state is UserFailed) {
            CustomSnackbar.show(context, state.reason.toString());
          }
        },
        builder: (context, state) {
          final isEditable = context.read<UserCubit>().isEditable;
          return Scaffold(
            backgroundColor: AppColors.light,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: AppColors.primary,
              leading: isEditable || user == null
                  ? null
                  : IconButton(
                      icon: const Icon(
                        Icons.arrow_back,
                        color: AppColors.light,
                      ),
                      onPressed: () {
                        RouteManager.routerManagerPushUntil(
                          context: context,
                          routeName: RouteConstants.users,
                        );
                      },
                    ),
              elevation: 0,
              centerTitle: true,
              title: Text(
                user == null
                    ? 'New User'
                    : isEditable
                        ? 'Update Profile'
                        : 'Profile',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(color: AppColors.light),
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
                      if (user != null) return context.read<UserCubit>().getUserById(user!.id);
                      return Future(() => null);
                    },
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          user == null
                              ? NewForm()
                              : isEditable
                                  ? EditableForm(user: user!)
                                  : ViewForm(user: user!),
                        ],
                      ),
                    ),
                  ),
          );
        },
      ),
    );
  }

  FloatingActionButton _floatingActionButton(BuildContext context) {
    final UserCubit bloc = context.read<UserCubit>();
    return FloatingActionButton(
      backgroundColor: AppColors.primary,
      onPressed: () => bloc.isUpdateForm(),
      tooltip: 'Edit',
      child: const Icon(Icons.edit),
    );
  }
}
