import 'package:qcarder/utils/configuration/constants.dart';
import 'package:qcarder/utils/configuration/theme.dart';
import 'package:qcarder/cubit/user/user_cubit.dart';
import 'package:qcarder/cubit/user/user_state.dart';
import 'package:qcarder/utils/models/enums.dart';
import 'package:qcarder/utils/navigation/router_manager.dart';
import 'package:qcarder/screens/user/confirmation_dialog.dart';
import 'package:qcarder/screens/user/editable_form.dart';
import 'package:qcarder/screens/user/new_form.dart';
import 'package:qcarder/screens/user/view_form.dart';
import 'package:qcarder/widgets/shimmer_widget.dart';
import 'package:qcarder/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class UserScreen extends StatelessWidget {
  final String? userId;

  const UserScreen({super.key, this.userId});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        userId != null
            ? BlocProvider(create: (_) => UserCubit()..getUserById(userId!))
            : BlocProvider(create: (_) => UserCubit()),
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
              toolbarHeight: 70,
              automaticallyImplyLeading: false,
              backgroundColor: AppColors.darkPrimary,
              leading: isEditable || userId == null
                  ? null
                  : IconButton(
                      icon: const Icon(
                        Icons.arrow_back,
                        color: AppColors.light,
                      ),
                      onPressed: () {
                        RouteManager.pushAndRemoveAll(
                          context: context,
                          routeName: RouteConstants.users,
                        );
                      },
                    ),
              actions: [if (userId != null) _userActions(context, isEditable)],
              elevation: 0,
              centerTitle: true,
              title: Text(
                userId == null
                    ? 'New User'
                    : isEditable
                        ? 'Update Profile'
                        : 'Profile',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(color: AppColors.light),
              ),
            ),
            floatingActionButton: userId != null && !isEditable && state is! UserLoading
                ? _floatingActionButton(context)
                : null,
            floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
            body: state is UserLoading
                ? _userShimmer(context)
                : state is UserFailed
                    ? Center(child: Text(state.reason.toString()))
                    : RefreshIndicator(
                        onRefresh: () {
                          if (userId != null) {
                            return context.read<UserCubit>().getUserById(userId!);
                          }
                          return Future(() => null);
                        },
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              state is UserLoaded
                                  ? isEditable && state.user != null
                                      ? EditableForm(user: state.user!)
                                      : ViewForm(user: state.user!)
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

  PopupMenuButton _userActions(BuildContext context, bool isEdit) {
    return PopupMenuButton<String>(
      color: AppColors.light,
      onSelected: (String result) {
        switch (result) {
          case 'view':
            Uri uri = Uri.parse('https://qcarder.com/users/$userId');
            launchUrl(
              uri,
              mode: LaunchMode.externalApplication,
            );
            break;
          case 'edit':
            context.read<UserCubit>().isUpdateForm(userId!);
            break;
          case 'delete':
            showDialog(
              context: context,
              builder: (context) => ConfirmationDialog(
                action: ConfirmationDialogAction.delete,
                userId: userId,
              ),
            );
            break;
          default:
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        PopupMenuItem<String>(
          height: 35,
          value: 'view',
          child: Row(
            children: [
              const Icon(
                Icons.remove_red_eye_outlined,
                size: 22,
                color: AppColors.primary,
              ),
              const SizedBox(width: 10),
              Text(
                'View',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: AppColors.primary,
                    ),
              ),
            ],
          ),
        ),
        const PopupMenuItem<String>(
          height: 0.0,
          padding: EdgeInsets.zero,
          child: Divider(),
        ),
        if (!isEdit)
          PopupMenuItem<String>(
            height: 35,
            value: 'edit',
            child: Row(
              children: [
                const Icon(
                  Icons.edit,
                  size: 22,
                  color: AppColors.primary,
                ),
                const SizedBox(width: 10),
                Text(
                  'Update User',
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: AppColors.primary,
                      ),
                ),
              ],
            ),
          ),
        if (!isEdit)
          const PopupMenuItem<String>(
            height: 0.0,
            padding: EdgeInsets.zero,
            child: Divider(),
          ),
        PopupMenuItem<String>(
          height: 35,
          value: 'delete',
          child: Row(
            children: [
              const Icon(
                Icons.delete_outline_outlined,
                size: 22,
                color: AppColors.onError,
              ),
              const SizedBox(width: 10),
              Text(
                'Delete User',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: AppColors.onError,
                    ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _userShimmer(BuildContext context) => Shimmer(
        linearGradient: shimmerGradient(context),
        child: ShimmerLoading(
          isLoading: true,
          child: SingleChildScrollView(
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
                      color: Theme.of(context).colorScheme.shadow.withOpacity(0.2),
                    ),
                  ),
                  child: ClipOval(
                    child: Container(
                      color: Theme.of(context).colorScheme.shadow,
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
                    color: Theme.of(context).colorScheme.shadow,
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
        ),
      );

  FloatingActionButton _floatingActionButton(BuildContext context) {
    final UserCubit bloc = context.read<UserCubit>();
    return FloatingActionButton(
      backgroundColor: AppColors.primary,
      onPressed: () => bloc.isUpdateForm(userId!),
      tooltip: 'Edit',
      child: const Icon(Icons.edit),
    );
  }
}
