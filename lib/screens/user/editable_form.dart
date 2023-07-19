import 'dart:io';
import 'dart:typed_data';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:qcarder/configuration/image_constants.dart';
import 'package:qcarder/configuration/theme.dart';
import 'package:qcarder/cubit/avatar/avatar_cubit.dart';
import 'package:qcarder/cubit/avatar/avatar_state.dart';
import 'package:qcarder/cubit/user/user_cubit.dart';
import 'package:qcarder/cubit/user/user_state.dart';
import 'package:qcarder/helpers/file_helper.dart';
import 'package:qcarder/helpers/image_path_by_label.dart';
import 'package:qcarder/helpers/index.dart';
import 'package:qcarder/helpers/date_time.dart';
import 'package:qcarder/models/enums.dart';
import 'package:qcarder/screens/user/confirmation_dialog.dart';
import 'package:qcarder/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qcarder/widgets/snackbar.dart';
import 'package:qcarder_api/api.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class EditableForm extends StatefulWidget {
  final User user;

  const EditableForm({Key? key, required this.user}) : super(key: key);

  @override
  State<EditableForm> createState() => _EditableFormState();
}

class _EditableFormState extends State<EditableForm> {
  final TextEditingController _imageController = TextEditingController();
  final TextEditingController _displayNameController = TextEditingController();
  // final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _companyController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _birthdayController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  List<TextEditingController> _emailControllers = [TextEditingController()];
  final List<TextEditingController> _phoneControllers = [];
  final List<TextEditingController> _linkControllers = [];

  final List<Link> _links = [];
  final List<PhoneNumber> _phones = [];

  @override
  void initState() {
    super.initState();
    _imageController.text = widget.user.avatar ?? '';
    _displayNameController.text = widget.user.profile.displayName ?? '';
    _titleController.text = widget.user.profile.title ?? '';
    _companyController.text = widget.user.profile.company ?? '';
    _addressController.text = widget.user.profile.address ?? '';
    _birthdayController.text =
        widget.user.profile.birthday != null ? widget.user.profile.birthday!.ymd : '';
    _noteController.text = widget.user.profile.notes ?? '';
    // _categoryController.text = widget.user!.categories[0];
    _emailControllers = List<TextEditingController>.generate(
      widget.user.profile.emails.isNotEmpty ? widget.user.profile.emails.length : 1,
      (index) => TextEditingController(
        text: widget.user.profile.emails.isNotEmpty ? widget.user.profile.emails[index].email : '',
      ),
    );
    if (widget.user.profile.phoneNumbers.isNotEmpty &&
        widget.user.profile.phoneNumbers.isNotEmpty) {
      for (final phone in widget.user.profile.phoneNumbers) {
        _phones.add(phone);
        _phoneControllers.add(TextEditingController(text: phone.phoneNumber));
      }
    } else {
      _phoneControllers.add(TextEditingController());
      _phones.add(PhoneNumber(phoneNumber: _phoneControllers[0].text, label: '', country: ''));
    }
    if (widget.user.profile.links.isNotEmpty) {
      for (final link in widget.user.profile.links) {
        _links.add(link);
        _linkControllers.add(TextEditingController(text: link.link));
      }
    } else {
      _linkControllers.add(TextEditingController());
      _links.add(Link(link: _linkControllers[0].text, label: ''));
    }
  }

  @override
  void dispose() {
    super.dispose();
    _imageController.dispose();
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
    for (var controller in _linkControllers) {
      controller.dispose();
    }
    _links.clear();
    _phones.clear();
  }

  Uint8List? binaryImage;

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
              onTap: () async {
                File? file = await FileHelper.pickImage(context);
                var multipartFile = http.MultipartFile(
                  'avatar',
                  file!.readAsBytes().asStream(),
                  file.lengthSync(),
                  filename: file.path.split('/').last,
                  contentType: MediaType('image', 'jpeg'),
                );
                if (context.mounted) {
                  context.read<AvatarCubit>().uploadAvatar(widget.user.id, multipartFile);
                  binaryImage = await file.readAsBytes();
                  setState(() {});
                }
              },
              child: Stack(
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
                    child: BlocConsumer<AvatarCubit, AvatarState>(
                      listener: (context, state) {
                        if (state is AvatarFailed) {
                          CustomSnackbar.show(
                            context,
                            state.reason.toString(),
                            type: SnackbarType.error,
                          );
                        }
                      },
                      builder: (context, state) {
                        if (state is AvatarLoading) return const CircularProgressIndicator();
                        return ClipOval(
                          child: binaryImage != null
                              ? Image.memory(
                                  binaryImage!,
                                  fit: BoxFit.cover,
                                )
                              : widget.user.avatar != null &&
                                      widget.user.avatar!.isNotEmpty &&
                                      widget.user.avatar!.contains('https')
                                  ? CachedNetworkImage(
                                      height: 80,
                                      width: 80,
                                      imageUrl: widget.user.avatar ?? '',
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) =>
                                          const CircularProgressIndicator(
                                        color: AppColors.primary,
                                      ),
                                      errorWidget: (context, url, error) => const Icon(
                                        Icons.error,
                                        color: AppColors.onError,
                                      ),
                                    )
                                  : SvgPicture.asset(
                                      ImageConstants.user,
                                      width: 80,
                                      height: 80,
                                    ),
                        );
                      },
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
            linksWidget(),
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
                    SizedBox(
                      width: 150,
                      child: CustomButton(
                          title: 'Cancel',
                          isInverted: true,
                          onPressed: () => showDialog(
                                context: context,
                                builder: (context) => ConfirmationDialog(
                                  action: ConfirmationDialogAction.cancel,
                                  user: widget.user,
                                ),
                              )),
                    ),
                    const Spacer(),
                    SizedBox(
                      width: 150,
                      child: CustomButton(
                        title: 'Update',
                        onPressed: () {
                          final form = Form.of(context);
                          if (form.validate()) {
                            form.save();
                            showDialog(
                              context: context,
                              builder: (context) => ConfirmationDialog(
                                action: ConfirmationDialogAction.update,
                                user: widget.user,
                                updateProfile: _updateProfile(),
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
        for (int i = 0; i < _phones.length; i++) ...[
          Row(
            children: [
              Expanded(
                flex: 5,
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Phone',
                    prefixIcon: GestureDetector(
                      onTap: () => _showFlagsIcons(i),
                      child: Container(
                        width: 25,
                        height: 25,
                        padding: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: ClipOval(
                          child: SvgPicture.asset(
                            flagPathByName(_phones[i].country),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                  validator: _validator,
                  controller: _phoneControllers[i],
                  onChanged: (value) {
                    _phones[i].phoneNumber = _phoneControllers[i].text;
                  },
                ),
              ),
              if (_phones.length > 1)
                Expanded(
                  flex: 1,
                  child: IconButton(
                    onPressed: () {
                      _phoneControllers.removeAt(i);
                      _phones.removeAt(i);
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
          title: const Text('Add a new phone'),
          leading: const Icon(Icons.add_circle_rounded),
          onTap: () {
            _phoneControllers.add(TextEditingController());
            _phones
                .add(PhoneNumber(phoneNumber: _phoneControllers.last.text, country: '', label: ''));
            setState(() {});
          },
        )
      ],
    );
  }

  Widget linksWidget() {
    return Column(
      children: [
        for (int i = 0; i < _links.length; i++) ...[
          Row(
            children: [
              Expanded(
                flex: 5,
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Link',
                    prefixIcon: GestureDetector(
                      onTap: () => _showLinksIcons(i),
                      child: Container(
                        width: 25,
                        height: 25,
                        padding: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: ClipOval(
                          child: SvgPicture.asset(
                            linkPathByLabel(_links[i].label),
                            fit: BoxFit.cover,
                            color: AppColors.grey.withOpacity(0.7),
                          ),
                        ),
                      ),
                    ),
                  ),
                  controller: _linkControllers[i],
                  onChanged: (value) {
                    _links[i].link = _linkControllers[i].text;
                  },
                ),
              ),
              if (_links.length > 1)
                Expanded(
                  flex: 1,
                  child: IconButton(
                    onPressed: () {
                      _linkControllers.removeAt(i);
                      _links.removeAt(i);
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
          if (_links.length > 1) const SizedBox(height: 15),
        ],
        ListTile(
          title: const Text('Add a new link'),
          leading: const Icon(Icons.add_circle_rounded),
          onTap: () {
            _linkControllers.add(TextEditingController());
            _links.add(Link(link: '', label: _linkControllers.last.text));
            setState(() {});
          },
        )
      ],
    );
  }

  PatchUserProfileDto _updateProfile() {
    return PatchUserProfileDto(
      address: _addressController.text,
      birthday: DateFormat('MMM d, yyyy').parse(_birthdayController.text),
      company: _companyController.text,
      displayName: _displayNameController.text,
      notes: _noteController.text,
      title: _titleController.text,
      emails: _emailControllers.map((email) => Email(email: email.text, label: 'null')).toList(),
      phoneNumbers: _phones.asMap().entries.map<PhoneNumber>((entry) {
        int index = entry.key;
        PhoneNumber phone = entry.value;
        phone.phoneNumber = _phoneControllers[index].text;
        phone.label = 'null';
        phone.country = phone.country.isEmpty ? flagPathByName(phone.country) : phone.country;
        return phone;
      }).toList(),
      links: _linkControllers[0].text.isEmpty
          ? []
          : _links.asMap().entries.map<Link>((entry) {
              int index = entry.key;
              Link link = entry.value;
              link.link = _linkControllers[index].text;
              link.label = link.label.isNotEmpty ? link.label : 'link';
              return link;
            }).toList(),
    );
  }

  Future<void> _showLinksIcons(int linkIndex) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('CHOOSE AN ICON', textAlign: TextAlign.center),
          content: Wrap(
            children: List.generate(
              Links.values.length,
              (index) => ListTile(
                leading: Container(
                  width: 30,
                  height: 30,
                  decoration: const BoxDecoration(shape: BoxShape.circle),
                  child: ClipOval(
                    child: SvgPicture.asset(
                      linkPathByLabel(Links.values[index].toString().split('.')[1]),
                      fit: BoxFit.cover,
                      color: AppColors.primary,
                    ),
                  ),
                ),
                title: Text(Links.values[index].toString().split('.')[1].toUpperCase()),
                onTap: () {
                  _links[linkIndex].label = Links.values[index].toString().split('.')[1];
                  setState(() {});
                  Navigator.of(context).pop();
                },
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> _showFlagsIcons(int flagIndex) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('CHOOSE A COUNTRY', textAlign: TextAlign.center),
          content: Wrap(
            children: List.generate(
              Flags.values.length,
              (index) => ListTile(
                leading: Container(
                  width: 30,
                  height: 30,
                  decoration: const BoxDecoration(shape: BoxShape.circle),
                  child: ClipOval(
                    child: SvgPicture.asset(
                      flagPathByName(Flags.values[index].toString().split('.')[1]),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                title: Text(Flags.values[index].toString().split('.')[1].toUpperCase()),
                onTap: () {
                  _phones[flagIndex].country = Flags.values[index].toString().split('.')[1];
                  setState(() {});
                  Navigator.of(context).pop();
                },
              ),
            ),
          ),
        );
      },
    );
  }

  String? _validator(value) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }
    return null;
  }
}
