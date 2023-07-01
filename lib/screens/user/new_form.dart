import 'dart:typed_data';
import 'package:qcarder/configuration/image_constants.dart';
import 'package:qcarder/configuration/theme.dart';
import 'package:qcarder/cubit/user/user_cubit.dart';
import 'package:qcarder/cubit/user/user_state.dart';
import 'package:qcarder/helpers/file_helper.dart';
import 'package:qcarder/helpers/index.dart';
import 'package:qcarder/helpers/date_time.dart';
import 'package:qcarder/models/enums.dart';
import 'package:qcarder/screens/user/confirmation_dialog.dart';
import 'package:qcarder/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:qcarder_api/api.dart';

class NewForm extends StatefulWidget {
  const NewForm({Key? key}) : super(key: key);

  @override
  State<NewForm> createState() => _NewFormState();
}

class _NewFormState extends State<NewForm> {
  final TextEditingController _imageController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _displayNameController = TextEditingController();
  // final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _companyController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _birthdayController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  List<TextEditingController> _phoneControllers = [TextEditingController()];
  List<TextEditingController> _emailControllers = [TextEditingController()];

  @override
  void dispose() {
    super.dispose();
    _imageController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _displayNameController.dispose();
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
                        color: Theme.of(context).colorScheme.onSurface.withOpacity(0.3),
                      ),
                    ),
                    child:
                        //  widget.user != null || binaryImage != null
                        //     ? Image.memory(binaryImage!)
                        //     :
                        SvgPicture.asset(
                      ImageConstants.user,
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
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.edit,
                        color: AppColors.light,
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
            const SizedBox(height: 16),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Display Name',
                prefixIcon: Icon(Icons.person),
              ),
              controller: _displayNameController,
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

                    SizedBox(
                      width: 150,
                      child: CustomButton(
                        title: 'Cancel',
                        isInverted: true,
                        onPressed: () => showDialog(
                          context: context,
                          builder: (context) => ConfirmationDialog(
                            action: ConfirmationDialogAction.cancel,
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                    SizedBox(
                      width: 150,
                      child: CustomButton(
                        title: 'Create',
                        onPressed: () {
                          final form = Form.of(context);
                          if (form.validate()) {
                            form.save();

                            showDialog(
                              context: context,
                              builder: (context) => ConfirmationDialog(
                                action: ConfirmationDialogAction.add,
                                newUser: _createUser(),
                              ),
                            );
                          }
                        },
                      ),
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

  PatchUserProfileDto _createProfile() {
    return PatchUserProfileDto(
      address: _addressController.text,
      banner: '', //FIXME: to be deleted from BE
      birthday: DateFormat('MMM d, yyyy').parse(_birthdayController.text),
      company: _companyController.text,
      displayName: _displayNameController.text,
      notes: _noteController.text,
      title: _titleController.text,
      emails: _emailControllers
          .map((email) => Email(email: email.text, label: 'null'))
          .toList(), //FIXME
      phoneNumbers: _phoneControllers
          .map((phone) =>
              PhoneNumber(phoneNumber: phone.text, label: 'null', country: 'null')) //FIXME
          .toList(),
    );
  }

  PostUserDto _createUser() {
    return PostUserDto(
      firstName: _firstNameController.text,
      lastName: _lastNameController.text,
      email: _emailControllers[0].text,
      profile: _createProfile(),
    );
  }

  String? _validator(value) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }
    return null;
  }
}
