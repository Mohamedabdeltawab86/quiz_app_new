import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:sizer/sizer.dart';

import '../../utils/common_functions.dart';

class LoginTextField extends StatelessWidget {
  const LoginTextField({
    super.key,
    required this.controller,
    this.enabled,
    this.isEmail = true,
    this.keyboardType,
    this.digitsOnly,
    required this.icon,
    required this.label,
    this.validator,
  });

  final TextEditingController controller;
  final String? Function(String?)? validator;
  final bool? enabled;
  final bool isEmail;
  final TextInputType? keyboardType;
  final bool? digitsOnly;
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
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
      controller: controller,
      validator: validator ?? (value) => isEmail
          ? isValidEmail(value, "email")
          : isValidPassword(value, "password"),
      enabled: enabled,
      keyboardType: keyboardType,
      inputFormatters: digitsOnly != null && digitsOnly!
          ? [FilteringTextInputFormatter.digitsOnly]
          : null,
    );
  }
}
