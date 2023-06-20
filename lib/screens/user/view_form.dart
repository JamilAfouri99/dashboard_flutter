import 'package:dashboard/configuration/image_constants.dart';
import 'package:dashboard/configuration/theme.dart';
import 'package:dashboard/helpers/date_time.dart';
import 'package:dashboard/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ViewForm extends StatelessWidget {
  final User user;
  const ViewForm({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                clipBehavior: Clip.hardEdge,
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    width: 4,
                    color: AppColors.grey.withOpacity(0.2),
                  ),
                ),
                child: user.avatar != null
                    ? Image.network(
                        user.avatar!,
                        height: 50,
                        width: 50,
                        errorBuilder: (context, url, error) => const Icon(Icons.error),
                      )
                    : SvgPicture.asset(
                        ImageConstants.woman,
                        width: 50.0,
                        height: 50.0,
                      ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            user.firstName ?? '',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 8),
          // SizedBox(
          //     width: double.infinity,
          //     child: Wrap(
          //       alignment: WrapAlignment.center,
          //       children: [
          // for (final category in user.categories)
          //   Container(
          //     padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          //     decoration: BoxDecoration(
          //       borderRadius: BorderRadius.circular(16),
          //       color: Colors.grey[100],
          //     ),
          //     child: Text(
          //       category,
          //       style:
          //           Theme.of(context).textTheme.bodyMedium!.copyWith(color: AppColors.grey),
          //     ),
          //   ),
          //   ],
          // )),
          Divider(
            height: 30,
            color: AppColors.grey.withOpacity(0.3),
          ),
          ListTile(
            leading: const Icon(Icons.work_outline),
            title: Text(
              user.profile!.title ?? '',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          ListTile(
            leading: const Icon(Icons.business),
            title: Text(
              user.profile!.company ?? '',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          _emailsWidget(context),
          _phonesWidget(context),
          ListTile(
            leading: const Icon(Icons.pin_drop_outlined),
            title: Text(
              user.profile!.address ?? '',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          ListTile(
            leading: const Icon(Icons.cake_outlined),
            title: Text(
              user.profile!.birthday != null ? user.profile!.birthday!.ymd : '',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          ListTile(
            leading: const Icon(Icons.view_headline_rounded),
            title: Text(
              user.profile!.notes ?? '',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }

  Widget _emailsWidget(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: ListTile(
        leading: const Icon(Icons.mail_outline_outlined),
        // subtitle: Text(email.label),
        title: user.profile!.emails!.length > 1
            ? FittedBox(
                fit: BoxFit.scaleDown,
                child: DropdownButton<String>(
                  value: user.email,
                  isDense: false,
                  onChanged: (_) {},
                  items: user.profile!.emails!.map<DropdownMenuItem<String>>((value) {
                    return DropdownMenuItem<String>(
                      value: value.email,
                      child: Text(
                        value.email ?? '',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    );
                  }).toList(),
                ),
              )
            : Text(
                user.email ?? '',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
      ),
    );
  }

  Widget _phonesWidget(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: ListTile(
        leading: const Icon(Icons.phone_outlined),
        // subtitle: Text(phone.label),
        title: user.profile!.phones!.length > 1
            ? DropdownButton<String>(
                onChanged: (_) {},
                value: user.profile!.phones![0].phone,
                items: user.profile!.phones!.map<DropdownMenuItem<String>>((Phone value) {
                  return DropdownMenuItem<String>(
                    value: value.phone,
                    child: Text(
                      value.phone ?? '',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  );
                }).toList(),
              )
            : Text(
                user.profile!.phones![0].phone ?? '',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
      ),
    );
  }
}
