import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/auth_controller.dart';
import 'login_page.dart';
import 'signup/signup_intro_page.dart';

class LoginOrSignup extends StatelessWidget {
  const LoginOrSignup({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find();
    
    return Obx(
      () => authController.showLoginPage.value
          ? const LoginPage()
          : const SignupIntroPage(),
    );
  }
}
