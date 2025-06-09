import 'package:fit_start/utils/type_def.dart';
import 'package:flutter/material.dart';

class AuthInput extends StatelessWidget {
  final String hintText;
  final String labelText;
  final bool obscureText;
  final ValidatorCallBack validator;
  final TextEditingController controller;
  final IconData icon;
  const AuthInput({
    super.key,
    required this.validator,
    required this.hintText,
    required this.labelText,
    this.obscureText = false,
    required this.controller,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(labelText: labelText, prefixIcon: Icon(icon)),
      obscureText: obscureText,
    );
  }
}
