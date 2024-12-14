import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  var showPassword = false.obs;

  double responsiveHeight(double pixelValue, double screenHeight) {
    return screenHeight * (pixelValue / 928);
  }

  double responsiveWidth(double pixelValue, double screenWidth) {
    return screenWidth * (pixelValue / 428);
  }
}