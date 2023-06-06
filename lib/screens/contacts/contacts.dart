import 'package:dashboard/configuration/theme.dart';
import 'package:dashboard/cubit/contacts/contacts_cubit.dart';
import 'package:dashboard/cubit/contacts/contacts_state.dart';
import 'package:dashboard/models/contact.dart';
import 'package:dashboard/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContactsScreen extends StatelessWidget {
  const ContactsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ContactsCubit()..fetch(),
      child: Scaffold(
        appBar: appBar,
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25.0),
                        border: Border.all(color: Colors.grey.withOpacity(0.5)),
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Icon(
                              Icons.search,
                              color: AppColors.grey.withOpacity(0.5),
                            ),
                          ),
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: 'Search contacts',
                                border: InputBorder.none,
                                hintStyle: TextStyle(color: AppColors.grey.withOpacity(0.5)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: () {
                      // TODO: Add contact
                    },
                    child: Text('Add'),
                  ),
                ],
              ),
            ),
            // List of contacts
            Expanded(
              child: BlocBuilder<ContactsCubit, ContactsState>(
                builder: (context, state) {
                  if (state is FailedState) {
                    Text(state.reason.toString());
                  } else if (state is SuccessState) {
                    return _contacts(state.contacts);
                  }
                  return const Center(child: CircularProgressIndicator());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _contacts(List<Contact> contacts) {
  final groupedContacts = <String, List<Contact>>{};

  for (final contact in contacts) {
    final startingLetter = contact.name[0].toUpperCase();

    if (!groupedContacts.containsKey(startingLetter)) {
      groupedContacts[startingLetter] = [];
    }

    groupedContacts[startingLetter]!.add(contact);
  }

  return ListView(
    children: groupedContacts.keys.map((letter) {
      final groupContacts = groupedContacts[letter]!;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.grey.withOpacity(0.05),
              border: Border(
                top: BorderSide(color: AppColors.grey.withOpacity(0.1)),
                bottom: BorderSide(color: AppColors.grey.withOpacity(0.1)),
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 5),
            child: Text(
              letter,
              style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return _contact(groupContacts[index]);
            },
            itemCount: groupContacts.length,
          ),
        ],
      );
    }).toList(),
  );
}

Widget _contact(Contact contact) => ListTile(
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(50.0),
        child: Image.asset(
          contact.image,
          width: 50.0,
          height: 50.0,
        ),
      ),
      title: Text(contact.name),
      subtitle: Text(contact.position),
      onTap: () => print(contact.id),
    );
