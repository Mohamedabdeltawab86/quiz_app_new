import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sizer/sizer.dart';

class CommonTextField extends StatelessWidget {
  const CommonTextField({
    super.key,
    required this.label,
    required this.icon,
    this.validator,
    this.keyboardType,
    required this.controller,
  });

  final String label;
  final IconData icon;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: label,
        prefixIcon: Padding(
          padding: EdgeInsets.all(8.sp),
          child: FaIcon(icon),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 0.5.sp,
            color: Theme.of(context).colorScheme.error,
          ),
        ),
      ),
      validator: validator,
      keyboardType: keyboardType,
      controller: controller,
    );
  }
}
