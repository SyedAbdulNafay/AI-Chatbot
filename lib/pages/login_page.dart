import 'package:ai_chatbot/controllers/login_controller.dart';
import 'package:ai_chatbot/services/widgets/socials_button.dart';
import 'package:ai_chatbot/services/widgets/my_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  // total height of screen 47+796+85 = 928

  double responsiveWidth(double pixelValue) {
    double screenWidth = Get.mediaQuery.size.width;
    return screenWidth *
        (pixelValue / 428); // the Figma model is for a 428px width screen
  }

  double responsiveHeight(double pixelValue) {
    double screenHeight = Get.mediaQuery.size.height;
    return screenHeight *
        (pixelValue / 928); // the Figma model is for a 928px height screen
  }

  @override
  Widget build(BuildContext context) {
    final LoginController loginController = Get.put(LoginController());

    return Scaffold(
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: responsiveHeight(111)),

            // LOGO
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Get.theme.colorScheme.inversePrimary,
              ),
              padding: const EdgeInsets.all(8),
              child: Icon(
                Icons.gamepad,
                color: Get.theme.colorScheme.surface,
                size: 55,
              ),
            ),
            SizedBox(height: responsiveHeight(24)),

            // Title
            const Text(
              "Login to your account",
              style: TextStyle(fontSize: 40),
            ),
            SizedBox(height: responsiveHeight(16)),

            // Don't have an account?
            RichText(
                text: TextSpan(
              text: 'Don\'t have an account? ',
              style: TextStyle(color: Get.theme.colorScheme.tertiary),
              children: [
                TextSpan(
                    text: 'Sign Up',
                    style: TextStyle(color: Get.theme.colorScheme.primary))
              ],
            )),
            SizedBox(height: responsiveHeight(40)),

            // email text field
            MyTextfield(
              obscureText: false,
              controller: loginController.emailController,
              hintText: "Email",
              prefixIcon: Icons.email_outlined,
            ),
            SizedBox(height: responsiveHeight(24)),

            // password text field
            Obx(() => MyTextfield(
                  controller: loginController.passwordController,
                  hintText: "Password",
                  prefixIcon: Icons.key_rounded,
                  suffixIcon: IconButton(
                    icon: Icon(
                      loginController.showPassword.value
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: Get.theme.colorScheme.primary,
                    ),
                    onPressed: () {
                      loginController.showPassword.value =
                          !loginController.showPassword.value;
                    },
                  ),
                  obscureText: !loginController.showPassword.value,
                )),
            SizedBox(height: responsiveHeight(24)),

            // Forgot password button
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "Forgot Password?",
                  style: TextStyle(
                      color: Get.theme.colorScheme.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                )
              ],
            ),
            SizedBox(height: responsiveHeight(24)),

            // Login Button
            Container(
              padding: const EdgeInsets.symmetric(vertical: 18),
              width: double.maxFinite,
              decoration: BoxDecoration(
                  color: Get.theme.colorScheme.primary,
                  borderRadius: BorderRadius.circular(36)),
              child: Center(
                child: Text(
                  "Login",
                  style: TextStyle(
                      color: Get.theme.colorScheme.surface,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(height: responsiveHeight(24)),

            // or login with
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
                  padding: EdgeInsets.symmetric(horizontal: responsiveWidth(8)),
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
            SizedBox(height: responsiveHeight(24)),

            // social buttons
            Row(
              children: [
                const SocialsButton(
                  filePath: 'assets/images/google_logo.svg',
                  title: "Google",
                ),
                SizedBox(width: responsiveWidth(16)),
                const SocialsButton(
                  filePath: 'assets/images/facebook_logo.svg',
                  title: "Facebook",
                ),
              ],
            ),
            SizedBox(height: responsiveHeight(70)),

            // terms of use
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Terms of use"),
                SizedBox(width: responsiveWidth(16)),
                const Text("|"),
                SizedBox(width: responsiveWidth(16)),
                const Text("Privacy policy"),
              ],
            ),
            SizedBox(height: responsiveHeight(24)),
          ],
        ),
      ),
    );
  }
}
