import 'package:dashboard/configuration/image_constants.dart';
import 'package:dashboard/configuration/theme.dart';
import 'package:dashboard/helpers/index.dart';
import 'package:dashboard/models/contact.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ViewForm extends StatelessWidget {
  final DummyUser contact;
  const ViewForm({super.key, required this.contact});

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
          SizedBox(
              width: double.infinity,
              child: Wrap(
                alignment: WrapAlignment.center,
                children: [
                  for (final category in contact.categories)
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.grey[100],
                      ),
                      child: Text(
                        category,
                        style:
                            Theme.of(context).textTheme.bodyMedium!.copyWith(color: AppColors.grey),
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
          _emailsWidget(context),
          _phonesWidget(context),
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

  Widget _emailsWidget(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: ListTile(
        leading: const Icon(Icons.mail_outline_outlined),
        // subtitle: Text(email.label),
        title: DropdownButton<String>(
          value: contact.emails[0].email,
          isDense: false,
          onChanged: (_) {},
          items: contact.emails.map<DropdownMenuItem<String>>((Email value) {
            return DropdownMenuItem<String>(
              value: value.email,
              child: Text(
                value.email,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _phonesWidget(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: ListTile(
        leading: const Icon(Icons.phone_outlined),
        // subtitle: Text(phone.label),
        title: DropdownButton<String>(
          onChanged: (_) {},
          value: contact.phones[0].phone,
          items: contact.phones.map<DropdownMenuItem<String>>((Phone value) {
            return DropdownMenuItem<String>(
              value: value.phone,
              child: Text(
                value.phone,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
