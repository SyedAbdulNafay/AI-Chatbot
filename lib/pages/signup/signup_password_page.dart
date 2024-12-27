import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:herbertai/pages/signup/signup_verification_page.dart';

import '../../controllers/auth_controller.dart';
import '../../controllers/layout_controller.dart';
import '../../services/widgets/authen_button.dart';
import '../../services/widgets/my_textfield.dart';

class SignupPasswordPage extends StatelessWidget {
  const SignupPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    final LayoutController layoutController = Get.find();
    final AuthController authController = Get.find();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: Icon(
          CupertinoIcons.back,
          color: Get.theme.colorScheme.inversePrimary,
          size: 32,
        ),
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            double screenHeight = constraints.maxHeight;
            double screenWidth = constraints.maxWidth;

            return Padding(
              padding: EdgeInsets.only(
                left: layoutController.responsiveWidth(24, screenWidth),
                right: layoutController.responsiveWidth(24, screenWidth),
                bottom: layoutController.responsiveHeight(100, screenHeight),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Sign Up',
                    style: TextStyle(
                        color: Get.theme.colorScheme.inversePrimary,
                        fontFamily: 'HeadingFont',
                        fontSize: 40),
                  ),
                  SizedBox(
                    height: layoutController.responsiveHeight(24, screenHeight),
                  ),
                  Form(
                      key: authController.signupPasswordFormKey,
                      child: Column(
                        children: [
                          Obx(() => MyTextfield(
                                hintText: 'Password',
                                prefixIcon: Icons.key,
                                controller: authController.passwordController,
                                validator: authController.passwordValidator,
                                obscureText: !authController.showPassword.value,
                                suffixIcon: GestureDetector(
                                  onTap: () {
                                    authController.showPassword.value =
                                        !authController.showPassword.value;
                                  },
                                  child: Icon(
                                    authController.showPassword.value
                                        ? Icons.visibility_off_outlined
                                        : Icons.visibility_outlined,
                                    color: Get.theme.colorScheme.primary,
                                  ),
                                ),
                                screenWidth: screenWidth,
                                screenHeight: screenHeight,
                              )),
                          SizedBox(
                            height: layoutController.responsiveHeight(
                                32, screenHeight),
                          ),
                          Obx(() => AuthenButton(
                                title: "Continue",
                                isLoading: authController.isSigningIn.value,
                                screenWidth: screenWidth,
                                screenHeight: screenHeight,
                                onTap: () async {
                                  await authController.verifyPassword();
                                  authController.checkEmailVerified();
                                  Get.to(
                                    () => const SignupVerificationPage(),
                                    transition: Transition.rightToLeft,
                                  );
                                },
                              ))
                        ],
                      ))
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
