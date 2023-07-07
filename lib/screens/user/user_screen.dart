import 'package:qcarder/configuration/constants.dart';
import 'package:qcarder/configuration/theme.dart';
import 'package:qcarder/cubit/avatar/avatar_cubit.dart';
import 'package:qcarder/cubit/user/user_cubit.dart';
import 'package:qcarder/cubit/user/user_state.dart';
import 'package:qcarder/models/enums.dart';
import 'package:qcarder/navigation/router_manager.dart';
import 'package:qcarder/screens/user/confirmation_dialog.dart';
import 'package:qcarder/screens/user/editable_form.dart';
import 'package:qcarder/screens/user/new_form.dart';
import 'package:qcarder/screens/user/view_form.dart';
import 'package:qcarder/widgets/shimmer_widget.dart';
import 'package:qcarder/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qcarder_api/api.dart';

class UserScreen extends StatelessWidget {
  final User? user;

  const UserScreen({super.key, this.user});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        user != null
            ? BlocProvider(create: (_) => UserCubit()..getUserById(user!.id))
            : BlocProvider(create: (_) => UserCubit()),
        BlocProvider(create: (context) => AvatarCubit()),
      ],
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
              actions: [
                if (user != null)
                  PopupMenuButton<String>(
                    color: AppColors.light,
                    onSelected: (String result) {
                      switch (result) {
                        case 'delete':
                          showDialog(
                            context: context,
                            builder: (context) => ConfirmationDialog(
                              action: ConfirmationDialogAction.delete,
                              user: user,
                            ),
                          );
                          break;
                        default:
                      }
                    },
                    itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                      const PopupMenuItem<String>(
                        value: 'delete',
                        child: Text(
                          'Delete User',
                          style: TextStyle(color: AppColors.onError),
                        ),
                      ),
                    ],
                  )
              ],
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
                ? _userShimmer(context)
                : state is UserFailed
                    ? Center(child: Text(state.reason.toString()))
                    : RefreshIndicator(
                        onRefresh: () {
                          if (user != null) {
                            return context.read<UserCubit>().getUserById(user!.id);
                          }
                          return Future(() => null);
                        },
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              state is UserLoaded
                                  ? isEditable
                                      ? EditableForm(user: state.user ?? user!)
                                      : ViewForm(user: state.user ?? user!)
                                  : const NewForm()
                            ],
                          ),
                        ),
                      ),
          );
        },
      ),
    );
  }

  Widget _userShimmer(BuildContext context) => Shimmer(
        linearGradient: shimmerGradient,
        child: ShimmerLoading(
          isLoading: true,
          child: Column(
            children: [
              const SizedBox(height: 20),
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    width: 4,
                    color: AppColors.grey.withOpacity(0.2),
                  ),
                ),
                child: ClipOval(
                  child: Container(
                    color: AppColors.grey,
                    height: 120,
                    width: 120,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Container(
                width: 120,
                height: 20,
                decoration: BoxDecoration(
                  color: AppColors.grey,
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              const SizedBox(height: 8),
              Container(
                margin: const EdgeInsets.all(20),
                height: MediaQuery.of(context).size.height * 0.5,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.light,
                ),
              )
            ],
          ),
        ),
      );

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
