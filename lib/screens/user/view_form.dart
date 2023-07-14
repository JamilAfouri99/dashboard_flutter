import 'package:qcarder/configuration/image_constants.dart';
import 'package:qcarder/configuration/theme.dart';
import 'package:qcarder/helpers/date_time.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qcarder/helpers/image_path_by_label.dart';
import 'package:qcarder_api/api.dart';
import 'package:url_launcher/url_launcher.dart';

class ViewForm extends StatelessWidget {
  final User user;
  const ViewForm({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
      margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.2),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
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
              child:
                  user.avatar != null && user.avatar!.isNotEmpty && user.avatar!.contains('https')
                      ? Image.network(
                          user.avatar ?? '',
                          height: 120,
                          width: 120,
                          fit: BoxFit.cover,
                          errorBuilder: (context, url, error) => const Icon(
                            Icons.error,
                            color: AppColors.primary,
                          ),
                        )
                      : SvgPicture.asset(
                          ImageConstants.user,
                          width: 80.0,
                          height: 80.0,
                        ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            user.profile.displayName ?? '',
            style: Theme.of(context).textTheme.headlineMedium!.copyWith(color: AppColors.primary),
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
          Container(
            margin: EdgeInsets.only(top: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: AppColors.light,
              boxShadow: [
                BoxShadow(
                  color: AppColors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(
                    Icons.work_outline,
                    color: AppColors.primary,
                  ),
                  title: Text(
                    user.profile.title ?? '',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
                ListTile(
                  leading: const Icon(
                    Icons.business,
                    color: AppColors.primary,
                  ),
                  title: Text(
                    user.profile.company ?? '',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
                _emailsWidget(context),
                _phonesWidget(context),
                ListTile(
                  leading: const Icon(
                    Icons.pin_drop_outlined,
                    color: AppColors.primary,
                  ),
                  title: Text(
                    user.profile.address ?? '',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
                ListTile(
                  leading: const Icon(
                    Icons.cake_outlined,
                    color: AppColors.primary,
                  ),
                  title: Text(
                    user.profile.birthday != null ? user.profile.birthday!.ymd : '',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
                ListTile(
                  leading: const Icon(
                    Icons.view_headline_rounded,
                    color: AppColors.primary,
                  ),
                  title: Text(
                    user.profile.notes ?? '',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            child: Wrap(
              spacing: 16,
              runSpacing: 16,
              alignment: WrapAlignment.center,
              runAlignment: WrapAlignment.center,
              children: user.profile.links.map((link) {
                return Builder(builder: (context) {
                  return GestureDetector(
                    onTap: () {
                      Uri uri = Uri.parse(link.link);
                      launchUrl(uri);
                    },
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.white,
                      ),
                      child: ClipOval(
                        child: SvgPicture.asset(
                          linkPathByLabel(link.label),
                          fit: BoxFit.cover,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  );
                });
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _emailsWidget(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: ListTile(
        leading: const Icon(
          Icons.mail_outline_outlined,
          color: AppColors.primary,
        ),
        // subtitle: Text(email.label),
        title: user.profile.emails.isNotEmpty && user.profile.emails.length > 1
            ? DropdownButton<String>(
                value: user.email,
                isDense: false,
                onChanged: (_) {},
                items: user.profile.emails.map<DropdownMenuItem<String>>((value) {
                  return DropdownMenuItem<String>(
                    value: value.email,
                    child: SizedBox(
                      width: 200,
                      child: Text(
                        value.email,
                        overflow: TextOverflow.clip,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  );
                }).toList(),
              )
            : Text(
                user.email,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
      ),
    );
  }

  Widget _phonesWidget(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: ListTile(
        leading: const Icon(
          Icons.phone_outlined,
          color: AppColors.primary,
        ),
        // subtitle: Text(phone.label),
        title: user.profile.phoneNumbers.isNotEmpty && user.profile.phoneNumbers.length > 1
            ? DropdownButton<String>(
                onChanged: (_) {},
                value: user.profile.phoneNumbers[0].phoneNumber,
                items: user.profile.phoneNumbers.map<DropdownMenuItem<String>>((PhoneNumber value) {
                  return DropdownMenuItem<String>(
                    value: value.phoneNumber,
                    child: Text(
                      value.phoneNumber,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  );
                }).toList(),
              )
            : Text(
                user.profile.phoneNumbers.isNotEmpty
                    ? user.profile.phoneNumbers[0].phoneNumber
                    : '',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
      ),
    );
  }
}
