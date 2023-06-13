import 'dart:typed_data';
import 'package:dashboard/cubit/user/user_cubit.dart';
import 'package:dashboard/cubit/user/user_state.dart';
import 'package:dashboard/helpers/file_helper.dart';
import 'package:dashboard/helpers/index.dart';
import 'package:dashboard/configuration/index.dart';
import 'package:dashboard/models/contact.dart';
import 'package:dashboard/models/enums.dart';
import 'package:dashboard/screens/user/confirmation_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EditableForm extends StatefulWidget {
  final DummyUser? contact;

  const EditableForm({Key? key, this.contact}) : super(key: key);

  @override
  State<EditableForm> createState() => _EditableFormState();
}

class _EditableFormState extends State<EditableForm> {
  final TextEditingController _imageController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _companyController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _birthdayController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  List<TextEditingController> _emailControllers = [TextEditingController()];
  List<TextEditingController> _phoneControllers = [TextEditingController()];

  @override
  void initState() {
    super.initState();
    if (widget.contact != null) {
      _imageController.text = widget.contact!.image;
      _nameController.text = widget.contact!.name;
      _titleController.text = widget.contact!.title;
      _companyController.text = widget.contact!.company;
      _addressController.text = widget.contact!.address;
      _birthdayController.text = widget.contact!.birthday.ymd;
      _noteController.text = widget.contact!.note;
      _categoryController.text = widget.contact!.categories[0];
      _emailControllers = List<TextEditingController>.generate(
        widget.contact!.emails.length,
        (index) => TextEditingController(text: widget.contact!.emails[index].email),
      );
      _phoneControllers = List<TextEditingController>.generate(
        widget.contact!.phones.length,
        (index) => TextEditingController(text: widget.contact!.phones[index].phone),
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
    _imageController.dispose();
    _nameController.dispose();
    _titleController.dispose();
    _companyController.dispose();
    _addressController.dispose();
    _birthdayController.dispose();
    _noteController.dispose();
    for (var controller in _emailControllers) {
      controller.dispose();
    }
    for (var controller in _phoneControllers) {
      controller.dispose();
    }
  }

  Uint8List? binaryImage;
  Future<void> _pickImage() async {
    binaryImage = await FileHelper.takePicture(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
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
                  child: widget.contact != null && binaryImage != null
                      ? Image.memory(binaryImage!)
                      : SvgPicture.asset(ImageConstants.woman),
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
          ),
          const SizedBox(height: 16),
          TextField(
            decoration: const InputDecoration(
              labelText: 'Category',
              prefixIcon: Icon(Icons.category_outlined),
            ),
            controller: _categoryController,
          ),
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
          BlocBuilder<UserCubit, UserState>(builder: (context, state) {
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
                          contactId: widget.contact != null ? widget.contact!.id : null,
                        ),
                      );
                    },
                    child: const Text('Cancel'),
                  ),
                  const SizedBox(width: 2),
                  ElevatedButton(
                    onPressed: () {
                      if (widget.contact != null) {
                        showDialog(
                          context: context,
                          builder: (context) => ConfirmationDialog(
                            contactId: widget.contact!.id,
                            action: ConfirmationDialogAction.update,
                            contact: DummyUser(
                              id: widget.contact!.id,
                              name: _nameController.text,
                              image: ImageConstants.woman,
                              categories: [_categoryController.text],
                              title: _titleController.text,
                              company: _companyController.text,
                              emails: _emailControllers
                                  .map((email) => Email(email: email.text, label: ''))
                                  .toList(),
                              phones: _phoneControllers
                                  .map((phone) => Phone(phone: phone.text, label: ''))
                                  .toList(),
                              address: _addressController.text,
                              birthday: DateTime.now(),
                              note: _noteController.text,
                            ),
                          ),
                        );
                      } else {
                        showDialog(
                          context: context,
                          builder: (context) => ConfirmationDialog(
                            action: ConfirmationDialogAction.add,
                            contact: DummyUser(
                              id: generateSimpleId(),
                              name: _nameController.text,
                              image: ImageConstants.woman,
                              categories: [_categoryController.text],
                              title: _titleController.text,
                              company: _companyController.text,
                              emails: _emailControllers
                                  .map((email) => Email(email: email.text, label: ''))
                                  .toList(),
                              phones: _phoneControllers
                                  .map((phone) => Phone(phone: phone.text, label: ''))
                                  .toList(),
                              address: _addressController.text,
                              birthday: DateTime.now(),
                              note: _noteController.text,
                            ),
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: AppColors.light,
                      backgroundColor: AppColors.primary,
                    ),
                    child: Text(widget.contact != null ? 'Update' : 'Save'),
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
        ListView.builder(
            shrinkWrap: true,
            itemCount: _emailControllers.length,
            itemBuilder: (context, i) {
              return Column(children: [
                Row(
                  children: [
                    Expanded(
                      flex: 5,
                      child: TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          prefixIcon: Icon(Icons.email),
                        ),
                        controller: _emailControllers[i],
                      ),
                    ),
                    if (_emailControllers.length > 1)
                      Expanded(
                        flex: 1,
                        child: IconButton(
                          onPressed: () {
                            setState(() {
                              _emailControllers.removeAt(i);
                            });
                          },
                          icon: const Icon(
                            Icons.delete_outline_rounded,
                            color: AppColors.onError,
                          ),
                        ),
                      )
                  ],
                ),
                if (_emailControllers.length > 1) const SizedBox(height: 15),
              ]);
            }),
        ListTile(
          title: const Text('Add an email address'),
          leading: const Icon(Icons.add_circle_rounded),
          onTap: () {
            setState(() {
              _emailControllers.add(TextEditingController());
            });
          },
        )
      ],
    );
  }

  Widget phonesWidget() {
    return Column(
      children: [
        for (int i = 0; i < _phoneControllers.length; i++) ...[
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
                ),
              ),
              if (_phoneControllers.length > 1)
                Expanded(
                  flex: 1,
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        _phoneControllers.removeAt(i);
                      });
                    },
                    icon: const Icon(
                      Icons.delete_outline_rounded,
                      color: AppColors.onError,
                    ),
                  ),
                )
            ],
          ),
          if (_phoneControllers.length > 1) const SizedBox(height: 15),
        ],
        ListTile(
          title: const Text('Add a phone number'),
          leading: const Icon(Icons.add_circle_rounded),
          onTap: () {
            setState(() {
              _phoneControllers.add(TextEditingController());
            });
          },
        )
      ],
    );
  }
}
