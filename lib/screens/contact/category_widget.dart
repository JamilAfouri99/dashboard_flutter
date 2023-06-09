import 'package:dashboard/configuration/theme.dart';
import 'package:flutter/material.dart';

class CategoryWidget extends StatefulWidget {
  const CategoryWidget({super.key});

  @override
  _CategoryWidgetState createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {
  bool _isDropdownOpen = false;
  final List<String> _selectedOptions = [];
  List<String> options = [
    'Company',
    'Home',
    'Work',
    'School',
  ];

  void _toggleDropdown() {
    setState(() {
      _isDropdownOpen = !_isDropdownOpen;
    });
  }

  void _handleOptionSelected(String option) {
    setState(() {
      if (_selectedOptions.contains(option)) {
        _selectedOptions.remove(option);
      } else {
        _selectedOptions.add(option);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: double.infinity,
            child: Wrap(
              alignment: WrapAlignment.start,
              children: [
                for (final option in _selectedOptions)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    margin: const EdgeInsets.all(1.5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(999),
                      color: AppColors.grey.withOpacity(0.1),
                    ),
                    child: Text(
                      option,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: AppColors.grey.withOpacity(0.9),
                          ),
                    ),
                  ),
              ],
            ),
          ),
          GestureDetector(
            onTap: _toggleDropdown,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              margin: const EdgeInsets.only(top: 1.5, bottom: 1.5, right: 1.5, left: 1.5),
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(999),
                color: AppColors.grey.withOpacity(0.1),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.edit,
                    size: 24.0,
                    color: AppColors.grey.withOpacity(0.8),
                  ),
                  const SizedBox(width: 4.0),
                  Text(
                    'Edit',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: AppColors.grey.withOpacity(0.9),
                        ),
                  ),
                ],
              ),
            ),
          ),
          if (_isDropdownOpen)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              margin: const EdgeInsets.only(left: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: AppColors.grey.withOpacity(0.1),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (String option in options)
                    CheckboxListTile(
                      value: _selectedOptions.contains(option),
                      onChanged: (bool? value) => _handleOptionSelected(option),
                      title: Text(option),
                    ),
                  ElevatedButton(
                    onPressed: _toggleDropdown,
                    child: Text('Save'),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
