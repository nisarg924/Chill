import 'package:flutter/material.dart';

class LoginTextfield extends StatelessWidget {
  const LoginTextfield({
    super.key,
    required this.controller,
    required this.labelText,
    this.prefixIcon,
    this.keyboardType,
    this.autofillHints,
    this.isPassword,
  });

  final TextEditingController controller;
  final String labelText;
  final IconData? prefixIcon;
  final TextInputType? keyboardType;
  final List<String>? autofillHints;
  final bool? isPassword;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      enableSuggestions: true,
      autocorrect: true,
      autofillHints: autofillHints ?? [AutofillHints.name],
      obscureText: isPassword ?? false,
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        prefixIcon: Icon(prefixIcon ?? Icons.question_mark),
      ),
      keyboardType: keyboardType ?? TextInputType.text,
    );
  }
}
