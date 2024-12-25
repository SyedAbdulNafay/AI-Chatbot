import 'package:ai_chatbot/controllers/layout_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/auth_controller.dart';
import '../services/widgets/my_textfield.dart';
import '../services/widgets/socials_button.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final LayoutController layoutController = Get.put(LayoutController());
    final AuthController loginController = Get.put(AuthController());

    return Scaffold(
      backgroundColor: Get.theme.colorScheme.surface,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final screenHeight = constraints.maxHeight;
            final screenWidth = constraints.maxWidth;

            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal:
                        layoutController.responsiveWidth(32, screenWidth)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                          top: layoutController.responsiveHeight(
                              64, screenHeight)),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Get.theme.colorScheme.inversePrimary,
                      ),
                      padding: const EdgeInsets.all(12),
                      child: Icon(
                        Icons.gamepad,
                        color: Get.theme.colorScheme.surface,
                        size: 42,
                      ),
                    ),
                    SizedBox(
                        height: layoutController.responsiveHeight(
                            24, screenHeight)),
                    const Text(
                      "Login to your account",
                      style: TextStyle(fontSize: 40, fontFamily: 'HeadingFont'),
                    ),
                    SizedBox(
                        height: layoutController.responsiveHeight(
                            16, screenHeight)),
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
                    SizedBox(
                        height: layoutController.responsiveHeight(
                            40, screenHeight)),
                    // MyTextfield(
                    //   hintText: "Email",
                    //   prefixIcon: Icons.email_outlined,
                    //   obscureText: loginController.showPassword.value,
                    // ),
                    // SizedBox(
                    //     height: layoutController.responsiveHeight(
                    //         24, screenHeight)),
                    // MyTextfield(
                    //   hintText: "Password",
                    //   prefixIcon: Icons.key_rounded,
                    //   obscureText: loginController.showPassword.value,
                    // ),
                    SizedBox(
                        height: layoutController.responsiveHeight(
                            24, screenHeight)),
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
                    SizedBox(
                        height: layoutController.responsiveHeight(
                            32, screenHeight)),
                    Container(
                      padding: EdgeInsets.symmetric(
                          vertical: layoutController.responsiveHeight(
                              18, screenHeight)),
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
                    SizedBox(
                        height: layoutController.responsiveHeight(
                            32, screenHeight)),
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
                    SizedBox(
                        height: layoutController.responsiveHeight(
                            32, screenHeight)),
                    // social buttons
                    // const Row(
                    //   children: [
                    //     SocialsButton(
                    //       filePath: 'assets/images/google_logo.svg',
                    //       title: "Google",
                    //     ),
                    //     SocialsButton(
                    //       filePath: 'assets/images/facebook_logo.svg',
                    //       title: "Facebook",
                    //     ),
                    //   ],
                    // ),
                    SizedBox(
                        height: layoutController.responsiveHeight(
                            90, screenHeight)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Terms of use"),
                        SizedBox(width: screenWidth * 0.02),
                        const Text("|"),
                        SizedBox(width: screenWidth * 0.02),
                        const Text("Privacy policy"),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
