import 'package:dashboard/configuration/image_constants.dart';
import 'package:dashboard/configuration/theme.dart';
import 'package:dashboard/helpers/index.dart';
import 'package:dashboard/models/contact.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ViewForm extends StatelessWidget {
  final Contact contact;
  const ViewForm({super.key, required this.contact});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
      child: Column(
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
                child: SvgPicture.asset(ImageConstants.woman),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            contact.name,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 8),
          Container(
              width: double.infinity,
              child: Wrap(
                alignment: WrapAlignment.start,
                children: [
                  for (final category in contact.categories)
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.grey[100],
                      ),
                      child: Text(
                        category,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                ],
              )),
          Divider(
            height: 30,
            color: AppColors.grey.withOpacity(0.3),
          ),
          ListTile(
            leading: const Icon(Icons.work_outline),
            title: Text(
              contact.title,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          ListTile(
            leading: const Icon(Icons.business),
            title: Text(
              contact.company,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          ListTile(
            leading: const Icon(Icons.mail_outline_outlined),
            title: Text(
              contact.emails[0].email,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            subtitle: Text(contact.emails[0].label),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.phone_outlined),
            title: Text(
              formatPhoneNumber(contact.phones[0].phone),
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            subtitle: Text(contact.phones[0].label),
          ),
          ListTile(
            leading: const Icon(Icons.pin_drop_outlined),
            title: Text(
              contact.address,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          ListTile(
            leading: const Icon(Icons.cake_outlined),
            title: Text(
              contact.birthday.ymd,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          ListTile(
            leading: const Icon(Icons.view_headline_rounded),
            title: Text(
              contact.note,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}
