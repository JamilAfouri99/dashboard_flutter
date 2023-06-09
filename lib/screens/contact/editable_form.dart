// TODO:
// Implement image update
// Implement category
// implement phones

import 'dart:async';
import 'dart:io';
import 'package:dashboard/configuration/theme.dart';
import 'package:dashboard/cubit/contact/contact_cubit.dart';
import 'package:dashboard/cubit/contact/contact_state.dart';
import 'package:dashboard/helpers/index.dart';
import 'package:dashboard/configuration/index.dart';
import 'package:dashboard/models/contact.dart';
import 'package:dashboard/models/enums.dart';
import 'package:dashboard/navigation/router_manager.dart';
import 'package:dashboard/screens/contact/confirmation_dialog.dart';
import 'package:dashboard/screens/contact/contact_screen.dart';
import 'package:dashboard/screens/contacts/contacts.dart';
import 'package:dashboard/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

class EditableForm extends StatefulWidget {
  final Contact? contact;

  const EditableForm({Key? key, this.contact}) : super(key: key);

  @override
  State<EditableForm> createState() => _EditableFormState();
}

class _EditableFormState extends State<EditableForm> {
  final TextEditingController _imageController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  // final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _companyController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _birthdayController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  List<TextEditingController> _emailControllers = [TextEditingController()];
  List<TextEditingController> _phoneControllers = [TextEditingController()];

  List<Email> _emails = [];
  List<Phone> _phones = [];

  @override
  void initState() {
    super.initState();
    if (widget.contact != null) {
      _imageController.text = widget.contact!.image;
      _nameController.text = widget.contact!.name;
      // _categoryController.text = widget.contact!.categories; //TODO: implement this
      _titleController.text = widget.contact!.title;
      _companyController.text = widget.contact!.company;
      _addressController.text = widget.contact!.address;
      _birthdayController.text = widget.contact!.birthday.ymd;
      _noteController.text = widget.contact!.note;
      _emailControllers = List<TextEditingController>.generate(
        widget.contact!.emails.length,
        (index) => TextEditingController(text: widget.contact!.emails[index].email),
      );
      _emails = widget.contact!.emails;
      _phoneControllers = List<TextEditingController>.generate(
        widget.contact!.phones.length,
        (index) => TextEditingController(text: widget.contact!.phones[index].phone),
      );
      _phones = widget.contact!.phones;
    }
  }

  @override
  Widget build(BuildContext context) {
    print('build run');
    ImagePicker _imagePicker = ImagePicker();
    String? _imagePath;

    void _pickImage() async {
      final pickedImage = await _imagePicker.pickImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        _imagePath = pickedImage.path;
      }
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () => _pickImage(),
            child: Stack(
              children: [
                Container(
                  clipBehavior: Clip.hardEdge,
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      width: 4,
                      color: Theme.of(context).colorScheme.onSurface.withOpacity(0.2),
                    ),
                  ),
                  child: _imagePath != null
                      ? Image.file(
                          File(_imagePath!),
                          fit: BoxFit.cover,
                        )
                      : widget.contact != null
                          ? SvgPicture.asset(widget.contact!.image)
                          : Container(),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    width: 30,
                    height: 30,
                    decoration: const BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.edit,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            decoration: const InputDecoration(
              labelText: 'Name',
              prefixIcon: Icon(Icons.person),
            ),
            controller: _nameController,
            onChanged: (value) {
              // Update the name field
            },
          ),
          const SizedBox(height: 8),
          // const CategoryWidget(), //TODO: implement this category widget
          const SizedBox(height: 16),
          TextField(
            decoration: const InputDecoration(
              labelText: 'Title',
              prefixIcon: Icon(Icons.title),
            ),
            controller: _titleController,
            onChanged: (value) {
              // Update the title field
            },
          ),
          const SizedBox(height: 16),
          TextField(
            decoration: const InputDecoration(
              labelText: 'Company',
              prefixIcon: Icon(Icons.business),
            ),
            controller: _companyController,
            onChanged: (value) {
              // Update the company field
            },
          ),
          const SizedBox(height: 16),
          emailsWidget(),
          const SizedBox(height: 16),
          phonesWidget(),
          const SizedBox(height: 16),
          TextField(
            decoration: const InputDecoration(
              labelText: 'Address',
              prefixIcon: Icon(Icons.location_on),
            ),
            controller: _addressController,
            onChanged: (value) {
              // Update the address field
            },
          ),
          const SizedBox(height: 16),
          TextField(
            decoration: const InputDecoration(
              labelText: 'Birthday',
              prefixIcon: Icon(Icons.calendar_today),
            ),
            controller: _birthdayController,
            onTap: () async {
              // Show date picker and update the birthday field
              DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(1900),
                lastDate: DateTime.now(),
              );
              if (pickedDate != null) {
                _birthdayController.text = pickedDate.ymd;
              }
            },
            readOnly: true,
          ),
          const SizedBox(height: 16),
          TextField(
            decoration: const InputDecoration(
              labelText: 'Note',
              prefixIcon: Icon(Icons.note),
            ),
            controller: _noteController,
            maxLines: null,
            keyboardType: TextInputType.multiline,
          ),
          const SizedBox(height: 24),
          BlocBuilder<ContactCubit, ContactState>(builder: (context, state) {
            return Container(
              margin: const EdgeInsets.only(top: 10),
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      if (widget.contact == null) {
                        return;
                      }

                      showDialog(
                        context: context,
                        builder: (context) => ConfirmationDialog(
                          action: ConfirmationDialogAction.delete,
                          contactId: widget.contact!.id,
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: AppColors.light,
                      backgroundColor: AppColors.onError,
                    ),
                    child: const Text('Delete'),
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => ConfirmationDialog(
                          action: ConfirmationDialogAction.cancel,
                          contactId: widget.contact!.id,
                        ),
                      );
                    },
                    child: const Text('Cancel'),
                  ),
                  const SizedBox(width: 2),
                  ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => ConfirmationDialog(
                          action: ConfirmationDialogAction.add,
                          contactId: widget.contact!.id,
                          contact: Contact(
                            id: generateSimpleId(),
                            name: _nameController.text,
                            position: _titleController.text,
                            image: _imageController.text,
                            categories: ['TODO'],
                            title: _titleController.text,
                            company: _companyController.text,
                            emails: _emails,
                            phones: _phones,
                            address: _addressController.text,
                            birthday: DateTime.now(),
                            note: _noteController.text,
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: AppColors.light,
                      backgroundColor: AppColors.primary,
                    ),
                    child: const Text('Save'),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget emailsWidget() {
    return Column(
      children: [
        for (int i = 0; i < _emails.length; i++) ...[
          Row(
            children: [
              Expanded(
                flex: 5,
                child: TextField(
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.email),
                  ),
                  controller: _emailControllers[i],
                  onChanged: (value) {
                    _emails[i].copyWith(email: value);
                    setState(() {});
                  },
                ),
              ),
              if (_emails.length > 1)
                Expanded(
                  flex: 1,
                  child: IconButton(
                    onPressed: () {
                      _emails.removeAt(i);
                      _emailControllers.remove(_emailControllers[i]);
                      setState(() {});
                    },
                    icon: const Icon(
                      Icons.delete_outline_rounded,
                      color: AppColors.onError,
                    ),
                  ),
                )
            ],
          ),
          if (_emails.length > 1) const SizedBox(height: 15),
        ],
        ListTile(
          title: const Text('Add an email address'),
          leading: const Icon(Icons.add_circle_rounded),
          onTap: () {
            _emails.add(
              Email(id: generateSimpleId(), email: '', label: ''),
            );
            _emailControllers.add(TextEditingController());
            setState(() {});
          },
        )
      ],
    );
  }

  Widget phonesWidget() {
    return Column(
      children: [
        for (int i = 0; i < _phones.length; i++) ...[
          Row(
            children: [
              Expanded(
                flex: 5,
                child: TextField(
                  decoration: const InputDecoration(
                    labelText: 'Phone',
                    prefixIcon: Icon(Icons.phone_outlined),
                  ),
                  controller: _phoneControllers[i],
                  onChanged: (value) {
                    _phones[i].copyWith(phone: value);
                    setState(() {});
                  },
                ),
              ),
              if (_phones.length > 1)
                Expanded(
                  flex: 1,
                  child: IconButton(
                    onPressed: () {
                      _phones.removeAt(i);
                      _phoneControllers.remove(_phoneControllers[i]);
                      setState(() {});
                    },
                    icon: const Icon(
                      Icons.delete_outline_rounded,
                      color: AppColors.onError,
                    ),
                  ),
                )
            ],
          ),
          if (_phones.length > 1) const SizedBox(height: 15),
        ],
        ListTile(
          title: const Text('Add a phone number'),
          leading: const Icon(Icons.add_circle_rounded),
          onTap: () {
            _phones.add(
              Phone(id: generateSimpleId(), phone: '', label: ''),
            );
            _phoneControllers.add(TextEditingController());
            setState(() {});
          },
        )
      ],
    );
  }

  void resetValues() {
    _emails = [];
    _imageController.text = '';
    _nameController.text = '';
    // _categoryController.text = '';
    _titleController.text = '';
    _companyController.text = '';
    _addressController.text = '';
    _birthdayController.text = '';
    _noteController.text = '';
    _emailControllers = [TextEditingController()];
    _phoneControllers = [TextEditingController()];
  }
}

Future<String?> confirmationDialog({
  required BuildContext context,
  required String title,
  required ContactState state,
  required Future<void> Function() onConfirm,
}) {
  final completer = Completer<String?>();

  showDialog(
    context: context,
    builder: (_) {
      return AlertDialog(
        title: Text(title),
        content: Text('Are you sure you want to ${title.toLowerCase()}?'),
        actions: [
          TextButton(
            onPressed: () {
              completer.complete(null); // Dialog canceled, complete with null
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              await onConfirm();
              if (state is SuccessState) {
                completer.complete('Confirmed'); // Dialog confirmed, complete with 'Confirmed'
              } else {
                completer.complete(null); // Dialog error
              }
            },
            child: const Text('Confirm'),
          ),
        ],
      );
    },
  );

  return completer.future;
}
