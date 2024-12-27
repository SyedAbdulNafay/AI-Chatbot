import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:herbertai/pages/home_page.dart';

import '../../controllers/auth_controller.dart';
import '../../controllers/layout_controller.dart';
import '../../services/widgets/authen_button.dart';

class SignupVerificationPage extends StatelessWidget {
  const SignupVerificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final LayoutController layoutController = Get.find();
    final AuthController authController = Get.find();

    return Obx(() => authController.isEmailVerified.value
        ? const HomePage()
        : Scaffold(
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
                      bottom:
                          layoutController.responsiveHeight(100, screenHeight),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Verification',
                          style: TextStyle(
                              color: Get.theme.colorScheme.inversePrimary,
                              fontFamily: 'HeadingFont',
                              fontSize: 40),
                        ),
                        SizedBox(
                          height: layoutController.responsiveHeight(
                              24, screenHeight),
                        ),
                        Text(
                          "A verification email has been sent to ${FirebaseAuth.instance.currentUser?.email}. Please verify before continuing",
                          style: TextStyle(
                            fontSize: 20,
                            color: Get.theme.colorScheme.inversePrimary,
                          ),
                        ),
                        SizedBox(
                          height: layoutController.responsiveHeight(
                              24, screenHeight),
                        ),
                        Text(
                          "Haven't gotten your email yet? ",
                          style: TextStyle(
                            color: Get.theme.colorScheme.inversePrimary,
                            fontSize: 18,
                          ),
                        ),
                        Obx(
                          () => Text(
                            "You can resend it in ${authController.countdownFormatted}",
                            style: TextStyle(
                                color: Get.theme.colorScheme.inversePrimary,
                                fontSize: 18),
                          ),
                        ),
                        Obx(() => AuthenButton(
                              disabled: !authController.canResendEmail.value,
                              screenHeight: screenHeight,
                              screenWidth: screenWidth,
                              title: "Resend",
                              onTap: () {
                                if (authController.canResendEmail.value) {
                                  authController.sendVerificationEmail();
                                }
                              },
                            ))
                      ],
                    ),
                  );
                },
              ),
            ),
          ));
  }
}
