import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyTextfield extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  const MyTextfield({
    super.key,
    this.hintText,
    this.prefixIcon,
    this.controller,
    this.suffixIcon,
    required this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: obscureText,
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
        hintText: hintText,
        hintStyle: TextStyle(
            color: Get.theme.colorScheme.tertiary, fontWeight: FontWeight.w600),
        prefixIcon: Icon(
          prefixIcon,
          color: Get.theme.colorScheme.tertiary,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Get.theme.colorScheme.outline),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Get.theme.colorScheme.outline),
        ),
      ),
    );
  }
}
