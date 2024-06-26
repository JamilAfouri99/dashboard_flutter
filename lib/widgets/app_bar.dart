import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qcarder/utils/configuration/theme.dart';
import 'package:qcarder/cubit/auth/auth_cubit.dart';
import 'package:qcarder/cubit/auth/auth_state.dart';
import 'package:qcarder/cubit/theme/theme_cubit.dart';
import 'package:qcarder/cubit/theme/theme_state.dart';

class GlobalAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const GlobalAppBar({super.key, this.title = 'Group Users'});

  @override
  AppBar build(BuildContext context) {
    return AppBar(
      toolbarHeight: 70,
      backgroundColor: AppColors.light,
      shadowColor: AppColors.light,
      foregroundColor: AppColors.light,
      surfaceTintColor: AppColors.light,
      leading: Builder(
        builder: (context) => IconButton(
          icon: const Icon(
            Icons.format_list_bulleted_rounded,
            color: AppColors.grey,
            size: 25,
          ),
          onPressed: () => Scaffold.of(context).openDrawer(),
        ),
      ),
      centerTitle: true,
      title: Text(
        title,
        style: Theme.of(context)
            .textTheme
            .headlineSmall!
            .copyWith(color: Theme.of(context).colorScheme.onPrimary),
      ),
      actions: [
        usersTopActions(context),
      ],
    );
  }

  Widget usersTopActions(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, theme) => BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) => {},
          builder: (context, state) {
            if (state is AuthenticatedState) {
              return PopupMenuButton<String>(
                color: AppColors.light,
                surfaceTintColor: AppColors.light,
                shadowColor: AppColors.light,
                onSelected: (result) {
                  switch (result) {
                    case 'theme':
                      context.read<ThemeCubit>().toggleTheme();
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
                          'User',
                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                color: Theme.of(context).colorScheme.shadow,
                              ),
                        ),
                        Text(
                          state.authUser.email,
                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                color: Theme.of(context).colorScheme.shadow.withOpacity(0.8),
                              ),
                        ),
                      ],
                    ),
                  ),
                  // const PopupMenuItem<String>(
                  //   height: 0.0,
                  //   padding: EdgeInsets.zero,
                  //   child: Divider(),
                  // ),
                  // // TODO: APP THEME
                  // PopupMenuItem<String>(
                  //   value: 'theme',
                  //   child: Row(
                  //     children: [
                  //       Icon(
                  //         theme.themeMode == ThemeMode.light
                  //             ? Icons.dark_mode_outlined
                  //             : Icons.light_mode_outlined,
                  //         size: 22,
                  //         color: Theme.of(context).colorScheme.shadow,
                  //       ),
                  //       const SizedBox(width: 5),
                  //       Text(
                  //         theme.themeMode == ThemeMode.light ? 'Dark Theme' : 'Light Theme',
                  //         style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  //               color: Theme.of(context).colorScheme.shadow,
                  //             ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  PopupMenuItem<String>(
                    height: 0.0,
                    padding: EdgeInsets.zero,
                    child: Divider(
                      color: AppColors.grey.withOpacity(0.3),
                    ),
                  ),
                  PopupMenuItem<String>(
                    value: 'logout',
                    child: Row(
                      children: [
                        Icon(
                          Icons.logout,
                          size: 22,
                          color: Theme.of(context).colorScheme.shadow,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          'Sign out',
                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                color: Theme.of(context).colorScheme.shadow,
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
