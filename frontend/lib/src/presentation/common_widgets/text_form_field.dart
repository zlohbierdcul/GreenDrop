import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final String hintText;
  final TextInputType? keyboardType;
  final Icon? icon;
  final Widget? suffixIcon;
  final String? label;
  final bool? obscureText;
  const CustomTextFormField({
    super.key,
    required this.controller,
    required this.hintText,
    this.validator,
    this.icon,
    this.keyboardType,
    this.label, this.suffixIcon, this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      obscureText: obscureText ?? false,
      keyboardType: keyboardType,
      decoration: InputDecoration(
          prefixIcon: icon,
          suffixIcon: suffixIcon,
          hintText: hintText,
          filled: true,
          fillColor: Theme.of(context).colorScheme.surfaceContainerHigh,
          label: label != null ? Text(label!) : null,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none)),
    );
  }
}
