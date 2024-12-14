import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/login_controller.dart';
import '../services/widgets/my_textfield.dart';
import '../services/widgets/socials_button.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final LoginController loginController = Get.put(LoginController());

    return Scaffold(
      backgroundColor: Get.theme.colorScheme.surface,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final availableHeight = constraints.maxHeight;
            final availableWidth = constraints.maxWidth;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: availableHeight * 0.1),
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Get.theme.colorScheme.inversePrimary,
                    ),
                    padding: EdgeInsets.all(availableWidth * 0.05),
                    child: Icon(
                      Icons.gamepad,
                      color: Get.theme.colorScheme.surface,
                      size: availableWidth * 0.15,
                    ),
                  ),
                  SizedBox(height: availableHeight * 0.02),
                  const Text(
                    "Login to your account",
                    style: TextStyle(fontSize: 40, fontFamily: 'HeadingFont'),
                  ),
                  SizedBox(height: availableHeight * 0.02),
                  RichText(
                    text: TextSpan(
                      text: 'Don\'t have an account? ',
                      style: TextStyle(color: Get.theme.colorScheme.tertiary),
                      children: [
                        TextSpan(
                          text: 'Sign Up',
                          style:
                              TextStyle(color: Get.theme.colorScheme.primary),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: availableHeight * 0.03),
                  Flexible(
                    child: Column(
                      children: [
                        MyTextfield(
                          hintText: "Email",
                          prefixIcon: Icons.email_outlined,
                          obscureText: loginController.showPassword.value,
                        ),
                        SizedBox(height: availableHeight * 0.02),
                        MyTextfield(
                          hintText: "Password",
                          prefixIcon: Icons.key_rounded,
                          obscureText: loginController.showPassword.value,
                        ),
                        SizedBox(height: availableHeight * 0.02),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "Forgot Password?",
                              style: TextStyle(
                                color: Get.theme.colorScheme.primary,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: availableHeight * 0.03),
                        Container(
                          padding: EdgeInsets.symmetric(
                              vertical: availableHeight * 0.02),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Get.theme.colorScheme.primary,
                            borderRadius: BorderRadius.circular(36),
                          ),
                          child: Center(
                            child: Text(
                              "Login",
                              style: TextStyle(
                                color: Get.theme.colorScheme.surface,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: availableHeight * 0.03,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Divider(
                          indent: 20,
                          color: Get.theme.colorScheme.outline,
                          height: 20,
                          thickness: 1,
                          endIndent: 10,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          'Or login with',
                          style: TextStyle(
                              color: Get.theme.colorScheme.tertiary,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          indent: 10,
                          color: Get.theme.colorScheme.outline,
                          height: 20,
                          thickness: 1,
                          endIndent: 20,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: availableHeight * 0.03),
                  // social buttons
                  const Row(
                    children: [
                      SocialsButton(
                        filePath: 'assets/images/google_logo.svg',
                        title: "Google",
                      ),
                      SocialsButton(
                        filePath: 'assets/images/facebook_logo.svg',
                        title: "Facebook",
                      ),
                    ],
                  ),
                  SizedBox(height: availableHeight * 0.02),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Terms of use"),
                      SizedBox(width: availableWidth * 0.02),
                      const Text("|"),
                      SizedBox(width: availableWidth * 0.02),
                      const Text("Privacy policy"),
                    ],
                  ),
                  SizedBox(height: availableHeight * 0.01),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
