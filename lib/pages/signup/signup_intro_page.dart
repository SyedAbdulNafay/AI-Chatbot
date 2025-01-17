import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/auth_controller.dart';
import '../../controllers/layout_controller.dart';
import '../../services/widgets/socials_button.dart';
import 'signup_email_page.dart';

class SignupIntroPage extends StatelessWidget {
  const SignupIntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    final LayoutController layoutController = Get.find();
    final AuthController authController = Get.find();

    return Scaffold(
      backgroundColor: Get.theme.colorScheme.surface,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final screenHeight = constraints.maxHeight;
            final screenWidth = constraints.maxWidth;

            return Padding(
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
                      height:
                          layoutController.responsiveHeight(24, screenHeight)),
                  const Text(
                    "Let's get you started",
                    style: TextStyle(fontSize: 40, fontFamily: 'HeadingFont'),
                  ),
                  SizedBox(
                      height:
                          layoutController.responsiveHeight(40, screenHeight)),
                  SocialsButton(
                      onTap: () => authController.signInWithGoogle(),
                      filePath: 'assets/images/google_logo.svg',
                      title: "Sign In with Google",
                      screenWidth: screenWidth,
                      screenHeight: screenHeight),
                  SizedBox(
                      height:
                          layoutController.responsiveHeight(24, screenHeight)),
                  SocialsButton(
                      filePath: 'assets/images/facebook_logo.svg',
                      title: "Sign In with Facebook",
                      screenWidth: screenWidth,
                      screenHeight: screenHeight),
                  SizedBox(
                      height:
                          layoutController.responsiveHeight(50, screenHeight)),
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
                          'Or sign up with',
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
                      height:
                          layoutController.responsiveHeight(50, screenHeight)),
                  SocialsButton(
                      onTap: () {
                        Get.to(() => const SignupEmailPage());
                      },
                      title: 'Email or Phone Number',
                      screenWidth: screenWidth,
                      screenHeight: screenHeight),
                  SizedBox(
                      height:
                          layoutController.responsiveHeight(32, screenHeight)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account? ",
                        style: TextStyle(
                            fontSize: 16,
                            color: Get.theme.colorScheme.tertiary),
                      ),
                      GestureDetector(
                        onTap: () => authController.showLoginPage.value = true,
                        child: Text(
                          "Log In",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Get.theme.colorScheme.primary),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
