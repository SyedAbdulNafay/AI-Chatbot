import 'package:ai_chatbot/controllers/auth_controller.dart';
import 'package:ai_chatbot/controllers/layout_controller.dart';
import 'package:ai_chatbot/services/widgets/authen_button.dart';
import 'package:ai_chatbot/services/widgets/my_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupEmailPage extends StatelessWidget {
  const SignupEmailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final LayoutController layoutController = Get.put(LayoutController());
    final AuthController authController = Get.put(AuthController());

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
                      key: authController.signupEmailFormKey,
                      child: Column(
                        children: [
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
                                32, screenHeight),
                          ),
                          // Obx(() => MysTextfield(
                          //       hintText: 'Password',
                          //       prefixIcon: Icons.key,
                          //       controller: authController.passwordController,
                          //       validator: authController.passwordValidator,
                          //       obscureText: !authController.showPassword.value,
                          //       suffixIcon: GestureDetector(
                          //         onTap: () {
                          //           authController.showPassword.value =
                          //               !authController.showPassword.value;
                          //         },
                          //         child: Icon(
                          //           authController.showPassword.value
                          //               ? Icons.visibility_off_outlined
                          //               : Icons.visibility_outlined,
                          //           color: Get.theme.colorScheme.primary,
                          //         ),
                          //       ),
                          //       screenWidth: screenWidth,
                          //       screenHeight: screenHeight,
                          //     )),
                          Obx(() => AuthenButton(
                                isLoading: authController.isSigningIn.value,
                                screenWidth: screenWidth,
                                screenHeight: screenHeight,
                                onTap: () => authController.verifyEmail(),
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
