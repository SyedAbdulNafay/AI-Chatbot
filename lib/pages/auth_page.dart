import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:herbertai/controllers/auth_controller.dart';
import 'package:herbertai/pages/home_page.dart';
import 'package:herbertai/pages/login_or_signup.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.put(AuthController());

    return Obx(() => authController.isUserLoggedIn.value
        ? const HomePage()
        : const LoginOrSignup());
  }
}
