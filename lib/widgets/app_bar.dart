import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qcarder/configuration/theme.dart';
import 'package:qcarder/cubit/auth/auth_cubit.dart';
import 'package:qcarder/cubit/auth/auth_state.dart';
import 'package:qcarder/cubit/theme/theme_cubit.dart';

class GlobalAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const GlobalAppBar({super.key, this.title = 'Group Users'});

  @override
  AppBar build(BuildContext context) {
    return AppBar(
      toolbarHeight: 70,
      leading: Builder(
        builder: (context) => IconButton(
          icon: const Icon(Icons.density_medium_outlined, color: AppColors.grey),
          onPressed: () => Scaffold.of(context).openDrawer(),
        ),
      ),
      backgroundColor: AppColors.light,
      centerTitle: true,
      title: Text(
        title,
        style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: AppColors.darkPrimary),
      ),
      actions: [
        usersTopActions(context),
      ],
    );
  }

  Widget usersTopActions(BuildContext context) {
    return BlocBuilder<ThemeCubit, bool>(
      builder: (context, state) => BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) => {},
          builder: (context, state) {
            if (state is AuthenticatedState) {
              return PopupMenuButton<String>(
                onSelected: (result) {
                  switch (result) {
                    case 'theme':
                      context.read<ThemeCubit>().toggleDarkTheme();
                      break;
                    case 'logout':
                      context.read<AuthCubit>().remoteLogout(context);
                      break;
                    default:
                  }
                },
                itemBuilder: (context) => <PopupMenuEntry<String>>[
                  PopupMenuItem<String>(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Signed in as',
                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                color: AppColors.grey,
                              ),
                        ),
                        Text(
                          state.authUser.email,
                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                color: AppColors.grey.withOpacity(0.8),
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
                  // PopupMenuItem<String>(
                  //   value: 'theme',
                  //   child: Row(
                  //     children: [
                  //       const Icon(
                  //         Icons.light_rounded,
                  //         size: 22,
                  //         color: AppColors.grey,
                  //       ),
                  //       const SizedBox(width: 5),
                  //       Text(
                  //         'Dark Theme',
                  //         style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  //               color: AppColors.grey,
                  //             ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // const PopupMenuItem<String>(
                  //   height: 0.0,
                  //   padding: EdgeInsets.zero,
                  //   child: Divider(),
                  // ),
                  PopupMenuItem<String>(
                    value: 'logout',
                    child: Row(
                      children: [
                        const Icon(
                          Icons.logout,
                          size: 22,
                          color: AppColors.grey,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          'Sign out',
                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                color: AppColors.grey,
                              ),
                        ),
                      ],
                    ),
                  ),
                ],
                child: Container(
                  margin: const EdgeInsets.all(10),
                  width: 40,
                  height: 40,
                  clipBehavior: Clip.antiAlias,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: state.authUser.avatar != null
                      ? CachedNetworkImage(
                          fit: BoxFit.cover,
                          cacheKey: state.authUser.avatar ?? '',
                          imageUrl: state.authUser.avatar ?? '',
                        )
                      : const Icon(
                          Icons.person,
                          color: AppColors.light,
                          size: 25,
                        ),
                ),
              );
            }
            return const CircularProgressIndicator();
          }),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(70);
}
