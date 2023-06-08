import 'package:dashboard/configuration/image_constants.dart';
import 'package:dashboard/configuration/theme.dart';
import 'package:dashboard/cubit/contact/contact_cubit.dart';
import 'package:dashboard/cubit/contact/contact_state.dart';
import 'package:dashboard/models/contact.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EditableForm extends StatelessWidget {
  final Contact? contact;

  const EditableForm({Key? key, this.contact}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController _imageController = TextEditingController();
    final TextEditingController _nameController = TextEditingController();
    final TextEditingController _categoryController = TextEditingController();
    final TextEditingController _titleController = TextEditingController();
    final TextEditingController _companyController = TextEditingController();
    final TextEditingController _emailController = TextEditingController();
    final TextEditingController _emailLabelController = TextEditingController();
    final TextEditingController _phoneController = TextEditingController();
    final TextEditingController _phoneLabelController = TextEditingController();
    final TextEditingController _addressController = TextEditingController();
    final TextEditingController _birthdayController = TextEditingController();
    final TextEditingController _noteController = TextEditingController();

    if (contact != null) {
      _nameController.text = contact!.name ?? '';
      _categoryController.text = contact!.name ?? '';
      _titleController.text = contact!.name ?? '';
      _companyController.text = contact!.name ?? '';
      _emailController.text = contact!.name ?? '';
      _emailLabelController.text = contact!.name ?? '';
      _phoneController.text = contact!.name ?? '';
      _phoneLabelController.text = contact!.name ?? '';
      _addressController.text = contact!.name ?? '';
      _birthdayController.text = contact!.name ?? '';
      _noteController.text = contact!.name ?? '';
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
      child: Form(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 80,
                  height: 80,
                  clipBehavior: Clip.hardEdge,
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
            SizedBox(height: 16),
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Name',
              ),
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return 'Please enter a name';
                }
                return null;
              },
            ),
            SizedBox(height: 8),
            TextFormField(
              controller: _categoryController,
              decoration: InputDecoration(
                labelText: 'Category',
              ),
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Title',
              ),
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: _companyController,
              decoration: InputDecoration(
                labelText: 'Company',
              ),
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
              ),
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: _emailLabelController,
              decoration: InputDecoration(
                labelText: 'Email Label',
              ),
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: _phoneController,
              decoration: InputDecoration(
                labelText: 'Phone',
              ),
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: _phoneLabelController,
              decoration: InputDecoration(
                labelText: 'Phone Label',
              ),
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: _addressController,
              decoration: InputDecoration(
                labelText: 'Address',
              ),
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: _birthdayController,
              decoration: InputDecoration(
                labelText: 'Birthday',
              ),
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: _noteController,
              decoration: InputDecoration(
                labelText: 'Note',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
