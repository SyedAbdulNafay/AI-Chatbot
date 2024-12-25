import 'package:ai_chatbot/pages/signup/signup_password_page.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // form keys
  final loginFormKey = GlobalKey<FormState>();
  final signupEmailFormKey = GlobalKey<FormState>();
  final signupPasswordFormKey = GlobalKey<FormState>();

  // controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final usernameController = TextEditingController();
  final confirmPWController = TextEditingController();

  // variables
  var isLoggingIn = false.obs;
  var isSigningIn = false.obs;
  var showPassword = false.obs;
  var emailError = RxnString();

  Future<void> verifyEmail() async {
    if (signupEmailFormKey.currentState!.validate()) {
      isSigningIn.value = true;

      try {
        final emailQuery = await FirebaseFirestore.instance
            .collection("Users")
            .where("email", isEqualTo: emailController.text.trim())
            .get();

        if (emailQuery.docs.isNotEmpty) {
          emailError.value = "This email is already in use.";
          isSigningIn.value = false;
          signupEmailFormKey.currentState!.validate();
          return;
        }

        emailError.value = null;
        Get.to(() => const SignupPasswordPage(),
            transition: Transition.rightToLeft);
      } catch (e) {
        debugPrint("Error: $e");
        isSigningIn.value = false;
      }
      isSigningIn.value = false;
    }
  }

  void verifyPassword() {
    if (signupPasswordFormKey.currentState!.validate()) {
      debugPrint("approved");
      _auth.sendSignInLinkToEmail(email: emailController.text, actionCodeSettings: actionCodeSettings)
    }
  }

  //validators
  String? emailValidator(String? email) {
    if (email == null || email.isEmpty) {
      return "This field cannot be empty";
    }
    debugPrint("1");
    if (!RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
        .hasMatch(email)) {
      return "Enter valid email";
    }
    debugPrint("2");
    if (emailError.value != null) {
      return emailError.value;
    }
    return null;
  }

  String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "This field cannot be empty";
    }
    if (value.length < 8) {
      return "Password must be longer than 8 characters";
    }
    return null;
  }

  String? confirmPWValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "This field cannot be empty";
    }
    if (value.length < 8) {
      return "Password must be longer than 8 characters";
    }
    if (confirmPWController.text != passwordController.text) {
      return "Passwords do not match";
    }
    return null;
  }
}
