import 'dart:typed_data';
import 'package:dashboard/cubit/user/user_cubit.dart';
import 'package:dashboard/cubit/user/user_state.dart';
import 'package:dashboard/helpers/file_helper.dart';
import 'package:dashboard/helpers/index.dart';
import 'package:dashboard/helpers/date_time.dart';
import 'package:dashboard/configuration/index.dart';
import 'package:dashboard/models/enums.dart';
import 'package:dashboard/models/user.dart';
import 'package:dashboard/models/user_request.dart';
import 'package:dashboard/screens/user/confirmation_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class EditableForm extends StatefulWidget {
  final User? user;

  const EditableForm({Key? key, this.user}) : super(key: key);

  @override
  State<EditableForm> createState() => _EditableFormState();
}

class _EditableFormState extends State<EditableForm> {
  final TextEditingController _imageController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  // final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _companyController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _birthdayController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  List<TextEditingController> _phoneControllers = [TextEditingController()];
  List<TextEditingController> _emailControllers = [TextEditingController()];

  @override
  void initState() {
    super.initState();
    if (widget.user != null) {
      _imageController.text = widget.user!.avatar ?? '';
      _firstNameController.text = widget.user!.firstName;
      _lastNameController.text = widget.user!.lastName;
      _titleController.text = widget.user!.profile.title ?? '';
      _companyController.text = widget.user!.profile.company ?? '';
      _addressController.text = widget.user!.profile.address ?? '';
      _birthdayController.text =
          widget.user!.profile.birthday != null ? widget.user!.profile.birthday!.ymd : '';
      _noteController.text = widget.user!.profile.notes ?? '';
      // _categoryController.text = widget.user!.categories[0];
      _emailControllers = List<TextEditingController>.generate(
        widget.user!.profile.emails!.length,
        (index) => TextEditingController(text: widget.user!.profile.emails![index].email),
      );
      _phoneControllers = List<TextEditingController>.generate(
        widget.user!.profile.phones!.length,
        (index) => TextEditingController(text: widget.user!.profile.phones![index].phone),
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
    _imageController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
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
      child: Form(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              // onTap: () => _pickImage(), // TODO: once the backend support this, will enable it
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
                    child:
                        (widget.user != null && widget.user!.avatar != null) || binaryImage != null
                            ? Image.memory(binaryImage!)
                            : widget.user != null &&
                                    widget.user!.avatar != null &&
                                    widget.user!.avatar!.isNotEmpty &&
                                    widget.user!.avatar!.contains('https')
                                ? Image.network(
                                    widget.user!.avatar!,
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
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'First Name',
                prefixIcon: Icon(Icons.person),
              ),
              controller: _firstNameController,
              validator: (value) => _validator(value),
            ),
            const SizedBox(height: 16),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Last Name',
                prefixIcon: Icon(Icons.person),
              ),
              controller: _lastNameController,
              validator: (value) => _validator(value),
            ),
            // const SizedBox(height: 16),
            // TextFormField(
            //   decoration: const InputDecoration(
            //     labelText: 'Category',
            //     prefixIcon: Icon(Icons.category_outlined),
            //   ),
            //   controller: _categoryController,
            //   validator: (value) => _validator(value),
            // ),
            const SizedBox(height: 16),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Title',
                prefixIcon: Icon(Icons.title),
              ),
              controller: _titleController,
            ),
            const SizedBox(height: 16),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Company',
                prefixIcon: Icon(Icons.business),
              ),
              controller: _companyController,
            ),
            const SizedBox(height: 16),
            emailsWidget(),
            const SizedBox(height: 16),
            phonesWidget(),
            const SizedBox(height: 16),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Address',
                prefixIcon: Icon(Icons.location_on),
              ),
              controller: _addressController,
            ),
            const SizedBox(height: 16),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Birthday',
                prefixIcon: Icon(Icons.calendar_today),
              ),
              controller: _birthdayController,
              validator: (value) => _validator(value),
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
            TextFormField(
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
                    // ElevatedButton(
                    //   onPressed: () {
                    //     if (widget.user == null) {
                    //       return;
                    //     }
                    //     showDialog(
                    //       context: context,
                    //       builder: (context) => ConfirmationDialog(
                    //         action: ConfirmationDialogAction.delete,
                    //         user: widget.user,
                    //       ),
                    //     );
                    //   },
                    //   style: ElevatedButton.styleFrom(
                    //     foregroundColor: AppColors.light,
                    //     backgroundColor: AppColors.onError,
                    //   ),
                    //   child: const Text('Delete'),
                    // ),
                    const Spacer(),
                    TextButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => const ConfirmationDialog(
                            action: ConfirmationDialogAction.cancel,
                          ),
                        );
                      },
                      child: const Text('Cancel'),
                    ),
                    const SizedBox(width: 2),
                    ElevatedButton(
                      onPressed: () {
                        final form = Form.of(context);
                        if (form.validate()) {
                          form.save();

                          if (widget.user != null) {
                            showDialog(
                              context: context,
                              builder: (context) => ConfirmationDialog(
                                action: ConfirmationDialogAction.update,
                                user: UserRequest(
                                  id: widget.user!.id,
                                  firstName: _firstNameController.text,
                                  lastName: _lastNameController.text,
                                  avatar: _imageController.text,
                                  // categories: [_categoryController.text],
                                  email: _emailControllers[0].text,
                                  profile: Profile(
                                    title: _titleController.text,
                                    company: _companyController.text,
                                    address: _addressController.text,
                                    birthday:
                                        DateFormat('MMM dd, yyyy').parse(_birthdayController.text),
                                    notes: _noteController.text,
                                    phones: _phoneControllers
                                        .map((phone) =>
                                            Phone(phone: phone.text, label: '', country: ''))
                                        .toList(),
                                    emails: _emailControllers
                                        .map((email) => Email(email: email.text, label: ''))
                                        .toList(),
                                  ),
                                ),
                              ),
                            );
                          } else {
                            showDialog(
                              context: context,
                              builder: (context) => ConfirmationDialog(
                                action: ConfirmationDialogAction.add,
                                user: _createdUser(),
                              ),
                            );
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: AppColors.light,
                        backgroundColor: AppColors.primary,
                      ),
                      child: Text(widget.user != null ? 'Update' : 'Save'),
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
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
                        validator: (value) => _validator(value),
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
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Phone',
                    prefixIcon: Icon(Icons.phone_outlined),
                  ),
                  controller: _phoneControllers[i],
                  validator: (value) => _validator(value),
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

  UserRequest _createdUser() {
    return UserRequest(
      firstName: _firstNameController.text,
      lastName: _lastNameController.text,
      avatar: _imageController.text.isEmpty ? null : _imageController.text,
      // categories: [_categoryController.text],
      email: _emailControllers[0].text,
      profile: Profile(
        title: _titleController.text.isEmpty ? null : _titleController.text,
        company: _companyController.text.isEmpty ? null : _companyController.text,
        address: _addressController.text.isEmpty ? null : _addressController.text,
        birthday: _birthdayController.text.isEmpty
            ? null
            : DateFormat('MMM dd, yyyy').parse(_birthdayController.text),
        notes: _noteController.text.isEmpty ? null : _noteController.text,
        phones: _phoneControllers.isEmpty || _phoneControllers[0].text.isEmpty
            ? null
            : _phoneControllers.map((phone) => Phone(phone: phone.text)).toList(),
        emails: _emailControllers.map((email) => Email(email: email.text)).toList(),
      ),
    );
  }

  String? _validator(value) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }
    return null;
  }
}
