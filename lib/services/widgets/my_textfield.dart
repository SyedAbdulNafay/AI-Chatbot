import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/layout_controller.dart';

class MyTextfield extends StatelessWidget {
  final double screenWidth;
  final double screenHeight;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final String? hintText;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final bool? obscureText;
  const MyTextfield({
    super.key,
    this.validator,
    this.hintText,
    this.prefixIcon,
    this.controller,
    this.suffixIcon,
    this.obscureText,
    required this.screenWidth,
    required this.screenHeight,
  });

  @override
  Widget build(BuildContext context) {
    final LayoutController layoutController = Get.find();

    return TextFormField(
      validator: validator,
      controller: controller,
      obscureText: obscureText ?? false,
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        contentPadding: EdgeInsets.symmetric(
            horizontal: layoutController.responsiveWidth(16, screenWidth),
            vertical: layoutController.responsiveHeight(22, screenHeight)),
        hintText: hintText,
        hintStyle: TextStyle(
            color: Get.theme.colorScheme.tertiary, fontWeight: FontWeight.w600),
        prefixIcon: Icon(
          prefixIcon,
          color: Get.theme.colorScheme.tertiary,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
              color: Get.theme.colorScheme.tertiary.withOpacity(0.28)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
              color: Get.theme.colorScheme.tertiary.withOpacity(0.28)),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Colors.red),
        ),
      ),
    );
  }
}
