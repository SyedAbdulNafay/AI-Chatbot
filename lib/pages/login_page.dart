import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../controllers/auth_controller.dart';
import '../controllers/layout_controller.dart';
import '../services/widgets/my_textfield.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

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
              child: Form(
                key: authController.loginFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: SvgPicture.asset(
                        'assets/svgs/login_vector.svg',
                      ),
                    ),
                    const Text(
                      "Login to your account",
                      style: TextStyle(fontSize: 40, fontFamily: 'HeadingFont'),
                    ),
                    SizedBox(
                        height: layoutController.responsiveHeight(
                            16, screenHeight)),
                    MyTextfield(
                      hintText: 'Email',
                      prefixIcon: Icons.email_outlined,
                      controller: authController.emailController,
                      validator: authController.emailValidator,
                      screenWidth: screenWidth,
                      screenHeight: screenHeight,
                    ),
                    SizedBox(
                        height: layoutController.responsiveHeight(
                            24, screenHeight)),
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
                            20, screenHeight)),
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
                            20, screenHeight)),
                    GestureDetector(
                      onTap: () async {
                        await authController.login();
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            vertical: layoutController.responsiveHeight(
                                18, screenHeight)),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Get.theme.colorScheme.primary,
                          borderRadius: BorderRadius.circular(36),
                        ),
                        child: Obx(() => Center(
                              child: authController.isLoggingIn.value
                                  ? CircularProgressIndicator(
                                      color: Get.theme.colorScheme.surface,
                                    )
                                  : Text(
                                      "Login",
                                      style: TextStyle(
                                        color: Get.theme.colorScheme.surface,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                            )),
                      ),
                    ),
                    SizedBox(
                        height: layoutController.responsiveHeight(
                            20, screenHeight)),
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
                      height:
                          layoutController.responsiveHeight(20, screenHeight),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () => authController.signInWithGoogle(),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24, vertical: 14),
                            decoration: BoxDecoration(
                                color: Get.theme.colorScheme.outline,
                                borderRadius: BorderRadius.circular(16)),
                            child: SvgPicture.asset(
                                'assets/images/google_logo.svg'),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 14),
                          decoration: BoxDecoration(
                              color: Get.theme.colorScheme.outline,
                              borderRadius: BorderRadius.circular(16)),
                          child: SvgPicture.asset(
                              'assets/images/facebook_logo.svg'),
                        ),
                      ],
                    ),
                    SizedBox(
                      height:
                          layoutController.responsiveHeight(16, screenHeight),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account? ",
                          style: TextStyle(
                            fontSize: 16,
                            color: Get.theme.colorScheme.tertiary,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            authController.showLoginPage.value = false;
                          },
                          child: Text(
                            "Sign Up",
                            style: TextStyle(
                              color: Get.theme.colorScheme.primary,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height:
                          layoutController.responsiveHeight(16, screenHeight),
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
