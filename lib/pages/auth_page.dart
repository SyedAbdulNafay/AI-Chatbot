import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/auth_controller.dart';
import '../controllers/layout_controller.dart';
import 'home_page.dart';
import 'login_or_signup.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.put(AuthController());
    Get.put(LayoutController());

    return Obx(() => authController.isUserLoggedIn.value
        ? const HomePage()
        : const LoginOrSignup());
  }
}
