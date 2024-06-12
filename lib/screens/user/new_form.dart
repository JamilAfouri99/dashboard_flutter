import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:http_parser/http_parser.dart';
import 'package:qcarder/utils/configuration/image-constants.dart';
import 'package:qcarder/utils/configuration/theme.dart';
import 'package:qcarder/cubit/user/user_cubit.dart';
import 'package:qcarder/cubit/user/user_state.dart';
import 'package:qcarder/utils/helpers/file_helper.dart';
import 'package:qcarder/utils/helpers/image_path_by_label.dart';
import 'package:qcarder/utils/helpers/index.dart';
import 'package:qcarder/utils/helpers/date_time.dart';
import 'package:qcarder/utils/models/enums.dart';
import 'package:qcarder/screens/user/confirmation_dialog.dart';
import 'package:qcarder/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:qcarder/widgets/custom_text_field.dart';
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
  final List<TextEditingController> _phoneControllers = [TextEditingController()];
  final List<TextEditingController> _phoneLabelControllers = [TextEditingController()];
  final List<TextEditingController> _emailControllers = [TextEditingController()];
  final List<TextEditingController> _emailLabelControllers = [TextEditingController()];
  final List<TextEditingController> _linkControllers = [TextEditingController()];

  final List<Link> _links = [];
  final List<PhoneNumber> _phones = [];
  final List<Email> _emails = [];
  http.MultipartFile? multipartFile;
  Uint8List? binaryImage;

  @override
  void initState() {
    super.initState();
    _links.add(Link(link: '', label: stringToEnumLink(_linkControllers[0].text)));
    _phones.add(PhoneNumber(
      phoneNumber: _phoneControllers[0].text,
      label: _phoneLabelControllers[0].text,
      country: 'XX',
    ));
    _emails.add(Email(email: _emailControllers[0].text, label: _emailLabelControllers[0].text));
  }

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
    for (var controller in _emailLabelControllers) {
      controller.dispose();
    }
    for (var controller in _phoneControllers) {
      controller.dispose();
    }
    for (var controller in _phoneLabelControllers) {
      controller.dispose();
    }
    for (var controller in _linkControllers) {
      controller.dispose();
    }
    _links.clear();
    _phones.clear();
    _emails.clear();
    multipartFile = null;
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
              onTap: () async {
                File? file = await FileHelper.pickImage(context);
                if (file == null) return;
                multipartFile = http.MultipartFile(
                  'avatar',
                  file.readAsBytes().asStream(),
                  file.lengthSync(),
                  filename: file.path.split('/').last,
                  contentType: MediaType('image', 'jpeg'),
                );
                binaryImage = await file.readAsBytes();
                setState(() {});
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
                        color: Theme.of(context).colorScheme.shadow.withOpacity(0.2),
                      ),
                    ),
                    child: ClipOval(
                      child: binaryImage != null
                          ? Image.memory(binaryImage!, fit: BoxFit.cover)
                          : Image.asset(
                              ImageConstants.placeholderUser,
                              width: 50.0,
                              height: 50.0,
                            ),
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
            CustomTextField(
              labelText: 'First Name',
              prefixIcon: const Icon(
                Icons.person,
                size: 25,
              ),
              scrollPadding: EdgeInsets.zero,
              controller: _firstNameController,
              validator: (value) => _validator(value),
            ),
            const SizedBox(height: 16),
            CustomTextField(
              labelText: 'Last Name',
              prefixIcon: const Icon(Icons.person_outline, size: 25),
              scrollPadding: EdgeInsets.zero,
              controller: _lastNameController,
              validator: (value) => _validator(value),
            ),
            const SizedBox(height: 16),
            CustomTextField(
              prefixIcon: const Icon(
                Icons.badge_outlined,
                size: 25,
              ),
              labelText: 'Display Name',
              scrollPadding: EdgeInsets.zero,
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
            CustomTextField(
              labelText: 'Title',
              prefixIcon: const Icon(
                Icons.title,
                size: 25,
              ),
              scrollPadding: EdgeInsets.zero,
              controller: _titleController,
            ),
            const SizedBox(height: 16),
            CustomTextField(
              labelText: 'Company',
              prefixIcon: const Icon(
                Icons.business,
                size: 25,
              ),
              scrollPadding: EdgeInsets.zero,
              controller: _companyController,
            ),
            const SizedBox(height: 16),
            emailsWidget(),
            const SizedBox(height: 16),
            phonesWidget(),
            const SizedBox(height: 16),
            linksWidget(),
            const SizedBox(height: 16),
            CustomTextField(
              labelText: 'Address',
              prefixIcon: const Icon(
                Icons.location_on_outlined,
                size: 25,
              ),
              scrollPadding: EdgeInsets.zero,
              controller: _addressController,
            ),
            const SizedBox(height: 16),
            CustomTextField(
              labelText: 'Birthday',
              prefixIcon: const Icon(
                Icons.calendar_month,
                size: 25,
              ),
              scrollPadding: EdgeInsets.zero,
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
            CustomTextField(
              labelText: 'Biography',
              prefixIcon: const Icon(
                Icons.description_outlined,
                size: 25,
              ),
              scrollPadding: EdgeInsets.zero,
              controller: _noteController,
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
                          builder: (context) => const ConfirmationDialog(
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
                                avatar: multipartFile,
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
                      flex: 4,
                      child: CustomTextField(
                        labelText: 'Email',
                        prefixIcon: const Icon(
                          Icons.email_outlined,
                          size: 25,
                        ),
                        inputFormatters: [FilteringTextInputFormatter.deny(RegExp(r'\s'))],
                        scrollPadding: EdgeInsets.zero,
                        controller: _emailControllers[i],
                        onChanged: (value) {
                          _emails[i].email = _emailControllers[i].text;
                        },
                        validator: (value) => _validator(value),
                      ),
                    ),
                    const SizedBox(width: 5),
                    Expanded(
                      flex: 2,
                      child: CustomTextField(
                        labelText: 'Label',
                        scrollPadding: EdgeInsets.zero,
                        controller: _emailLabelControllers[i],
                        onChanged: (value) {
                          _emails[i].label = _emailLabelControllers[i].text;
                        },
                        validator: (value) => _validator(value),
                      ),
                    ),
                    if (_emailControllers.length > 1)
                      Expanded(
                        flex: 1,
                        child: IconButton(
                          onPressed: () {
                            _emailControllers.removeAt(i);
                            _emailLabelControllers.removeAt(i);
                            _emails.removeAt(i);
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
                if (_emailControllers.length > 1) const SizedBox(height: 15),
              ]);
            }),
        Padding(
          padding: EdgeInsets.only(top: _emailControllers.length > 1 ? 0 : 15),
          child: InkWell(
            onTap: () {
              _emailControllers.add(TextEditingController());
              _emailLabelControllers.add(TextEditingController());
              _emails.add(Email(
                email: _emailControllers.last.text,
                label: _emailLabelControllers.last.text,
              ));
              setState(() {});
            },
            child: Row(
              children: [
                Icon(
                  Icons.add_circle_rounded,
                  size: 20,
                  color: Theme.of(context).colorScheme.shadow.withOpacity(0.7),
                ),
                const SizedBox(width: 10),
                Text(
                  'Add a new email',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // Widget phonesWidget() {
  //   return Column(
  //     children: [
  //       for (int i = 0; i < _phoneControllers.length; i++) ...[
  //         Row(
  //           children: [
  //             Expanded(
  //               flex: 5,
  //               child: TextFormField(
  //                 decoration: const InputDecoration(
  //                   labelText: 'Phone',
  //                   prefixIcon: Icon(Icons.phone_outlined),
  //                 ),
  //                 controller: _phoneControllers[i],
  //                 validator: (value) => _validator(value),
  //               ),
  //             ),
  //             if (_phoneControllers.length > 1)
  //               Expanded(
  //                 flex: 1,
  //                 child: IconButton(
  //                   onPressed: () {
  //                     setState(() {
  //                       _phoneControllers.removeAt(i);
  //                     });
  //                   },
  //                   icon: const Icon(
  //                     Icons.delete_outline_rounded,
  //                     color: AppColors.onError,
  //                   ),
  //                 ),
  //               )
  //           ],
  //         ),
  //         if (_phoneControllers.length > 1) const SizedBox(height: 15),
  //       ],
  //       ListTile(
  //         title: const Text('Add a phone number'),
  //         leading: const Icon(Icons.add_circle_rounded),
  //         onTap: () {
  //           setState(() {
  //             _phoneControllers.add(TextEditingController());
  //           });
  //         },
  //       )
  //     ],
  //   );
  // }

  Widget phonesWidget() {
    return Column(
      children: [
        for (int i = 0; i < _phones.length; i++) ...[
          Row(
            children: [
              Expanded(
                flex: 4,
                child: CustomTextField(
                  scrollPadding: EdgeInsets.zero,
                  labelText: 'Phone',
                  prefixIcon: const Icon(
                    Icons.phone,
                    size: 25,
                  ),
                  controller: _phoneControllers[i],
                  onChanged: (value) {
                    _phones[i].phoneNumber = _phoneControllers[i].text;
                  },
                ),
              ),
              const SizedBox(width: 5),
              Expanded(
                flex: 2,
                child: CustomTextField(
                  scrollPadding: EdgeInsets.zero,
                  labelText: 'Label',
                  controller: _phoneLabelControllers[i],
                  onChanged: (value) {
                    _phones[i].label = _phoneLabelControllers[i].text;
                  },
                ),
              ),
              if (_phones.length > 1)
                Expanded(
                  flex: 1,
                  child: IconButton(
                    onPressed: () {
                      _phoneControllers.removeAt(i);
                      _phoneLabelControllers.removeAt(i);
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
        Padding(
          padding: EdgeInsets.only(top: _phoneControllers.length > 1 ? 0 : 15),
          child: InkWell(
            onTap: () {
              _phoneControllers.add(TextEditingController());
              _phoneLabelControllers.add(TextEditingController());
              _phones.add(PhoneNumber(
                phoneNumber: _phoneControllers.last.text,
                label: _phoneLabelControllers.last.text,
                country: 'XX',
              ));
              setState(() {});
            },
            child: Row(
              children: [
                Icon(
                  Icons.add_circle_rounded,
                  size: 20,
                  color: Theme.of(context).colorScheme.shadow.withOpacity(0.7),
                ),
                const SizedBox(width: 10),
                Text(
                  'Add a new phone',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
        ),
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
                child: CustomTextField(
                  scrollPadding: EdgeInsets.zero,
                  labelText: 'Link',
                  prefixIcon: GestureDetector(
                    onTap: () => _showLinksIcons(i),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 25,
                          height: 25,
                          margin: const EdgeInsets.only(left: 12),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: ClipOval(
                            child: SvgPicture.asset(
                              linkPathByLabel(_links[i].label),
                              fit: BoxFit.cover,
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                        const Icon(Icons.arrow_drop_down),
                      ],
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
        Padding(
          padding: EdgeInsets.only(top: _linkControllers.length > 1 ? 0 : 15),
          child: InkWell(
            onTap: () {
              _linkControllers.add(TextEditingController());
              _links.add(Link(link: '', label: stringToEnumLink(_linkControllers.last.text)));
              setState(() {});
            },
            child: Row(
              children: [
                Icon(
                  Icons.add_circle_rounded,
                  size: 20,
                  color: Theme.of(context).colorScheme.shadow.withOpacity(0.7),
                ),
                const SizedBox(width: 10),
                Text(
                  'Add a new link',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  PatchUserProfileDto _createProfile() {
    return PatchUserProfileDto(
      address: _addressController.text,
      birthday: DateFormat('MMM d, yyyy').parse(_birthdayController.text),
      company: _companyController.text,
      displayName: _displayNameController.text,
      notes: _noteController.text,
      title: _titleController.text,
      emails: _emails,
      phoneNumbers: _phones,
      links: _linkControllers[0].text.isEmpty
          ? []
          : _links.asMap().entries.map<Link>((entry) {
              int index = entry.key;
              Link link = entry.value;
              link.link = _linkControllers[index].text;
              link.label = link.label.toString().isNotEmpty ? link.label : stringToEnumLink('link');
              return link;
            }).toList(),
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

  Future<void> _showLinksIcons(int linkIndex) {
    return showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Links',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.darkPrimary,
                ),
              ),
            ),
            Divider(
              color: AppColors.primary.withOpacity(0.2),
              height: 1,
            ),
            Expanded(
              child: ListView.separated(
                separatorBuilder: (context, index) => Divider(
                  color: AppColors.primary.withOpacity(0.2),
                  height: 10,
                ),
                padding: const EdgeInsets.all(10),
                itemCount: Links.values.length,
                itemBuilder: (context, index) {
                  String label = Links.values[index].toString().split('.')[1];
                  String formattedLabel = label[0].toUpperCase() + label.substring(1).toLowerCase();
                  return ListTile(
                    leading: Container(
                      width: 30,
                      height: 30,
                      decoration: const BoxDecoration(shape: BoxShape.circle),
                      child: ClipOval(
                        child: SvgPicture.asset(
                          linkPathByLabel(stringToEnumLink(label)),
                          fit: BoxFit.cover,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                    title: Text(
                      formattedLabel,
                      style: const TextStyle(color: AppColors.darkPrimary),
                    ),
                    onTap: () {
                      _links[linkIndex].label = stringToEnumLink(label);
                      setState(() {});
                      Navigator.of(context).pop();
                    },
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _showFlagsIcons(int flagIndex) {
    return showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      builder: (context) {
        return ListView.builder(
          padding: const EdgeInsets.all(10),
          itemCount: Flags.values.length,
          itemBuilder: (context, index) {
            return ListTile(
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
            );
          },
        );
      },
    );
  }

  String? _validator(value) {
    if (value == null || value.isEmpty) {
      return 'Required';
    }
    return null;
  }
}
