import 'package:dashboard/configuration/image_constants.dart';
import 'package:dashboard/configuration/theme.dart';
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
          SizedBox(height: 16),
          Text(
            'Alice Harding',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Container(
            padding: EdgeInsets.symmetric(vertical: 4, horizontal: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.grey[100],
            ),
            child: Text(
              'Band',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.grey[500],
              ),
            ),
          ),
          SizedBox(height: 16),
          ListTile(
            leading: Icon(Icons.work),
            title: Text('Track Service Worker'),
          ),
          ListTile(
            leading: Icon(Icons.business),
            title: Text('Futurity'),
          ),
          ListTile(
            leading: Icon(Icons.mail),
            title: Text('aliceharding@mail.us'),
            subtitle: Text('Personal'),
            onTap: () {
              // Add your email functionality here
            },
          ),
          ListTile(
            leading: Icon(Icons.phone),
            title: Text('+1 881 472 3113'),
            subtitle: Text('Mobile'),
          ),
          ListTile(
            leading: Icon(Icons.pin_drop_outlined),
            title: Text('387 HoltCourt, Thomasville, Alaska, PO2867'),
          ),
          ListTile(
            leading: Icon(Icons.cake_outlined),
            title: Text('September 17, 1985'),
          ),
          ListTile(
            leading: Icon(Icons.view_headline_rounded),
            title: Text(
                'Adipisicing exercitation dolor nisi ipsum nostrud anim dolore sint veniam consequat lorem sit ex commodo nostrud occaecat elit magna magna commodo incididunt laborum ad irure pariatur et sit ullamco adipisicing.Ullamco in dolore amet est quis consectetur fugiat non nisi incididunt id laborum adipisicing dolor proident velit ut quis aliquip dolore id anim sit adipisicing nisi incididunt enim amet pariatur.'),
          ),
        ],
      ),
    );
  }
}
