import 'dart:async';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../pages/home_page.dart';
import '../pages/signup/signup_password_page.dart';

class AuthController extends GetxController {
  final FirebaseAuth auth = FirebaseAuth.instance;
  UserCredential? _userCredential;

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
  var showLoginPage = true.obs;
  var canResendEmail = false.obs;
  var isEmailVerified = false.obs;
  var isUserLoggedIn = false.obs;
  var _countdown = 120.obs;
  Timer? _countdownTimer;
  var _emailError = RxnString();

  @override
  void onInit() {
    super.onInit();
    auth.authStateChanges().listen((user) {
      if (user != null) {
        isUserLoggedIn.value = true;
      } else {
        isUserLoggedIn.value = false;
      }
    });
  }

  String get countdownFormatted {
    int minutes = _countdown.value ~/ 60;
    int seconds = _countdown.value % 60;

    return '${minutes.toString().padLeft(1, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  signInWithGoogle() async {
    try {
      final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

      if (gUser == null) return;

      final GoogleSignInAuthentication gAuth = await gUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken,
        idToken: gAuth.idToken,
      );

      return await auth.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'account-exists-with-different-credential':
          Get.showSnackbar(const GetSnackBar(
            title: "Error",
            message:
                "There already exists an account with the email address asserted by the credential.",
          ));
          break;
        case 'invalid-credential':
          Get.showSnackbar(const GetSnackBar(
            title: "Error",
            message: "The credential is malformed or has expired.",
          ));
          break;
        case 'operation-not-allowed':
          Get.showSnackbar(const GetSnackBar(
            title: "Error",
            message:
                "The type of account corresponding to the credential is not enabled.",
          ));
          break;
        case 'user-disabled':
          Get.showSnackbar(const GetSnackBar(
            title: "Error",
            message:
                "The user corresponding to the given credential has been disabled.",
          ));
          break;
        case 'user-not-found':
          Get.showSnackbar(const GetSnackBar(
            title: "Error",
            message: "There is no user corresponding to the given email.",
          ));
          break;
        case 'wrong-password':
          Get.showSnackbar(const GetSnackBar(
            title: "Error",
            message:
                "The password is invalid for the given email, or if the account corresponding to the email does not have a password set.",
          ));
          break;
        default:
          Get.showSnackbar(const GetSnackBar(
            title: "Error",
            message: "Unexpected exception occured.",
          ));
      }
    }
  }

  Future<void> login() async {
    debugPrint(isUserLoggedIn.value.toString());
    if (loginFormKey.currentState!.validate()) {
      isLoggingIn.value = true;

      try {
        final query = FirebaseFirestore.instance
            .collection("Users")
            .where("email", isEqualTo: emailController.text.trim());
        final querysnapshot = await query.get();

        if (querysnapshot.docs.isEmpty) {
          Get.snackbar("Error", "This email is not valid");
          isLoggingIn.value = false;
          return;
        }

        await auth.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          Get.snackbar("Error", "User not found");
        }
      }
      isLoggingIn.value = false;
    }
  }

  Future<void> signOut() async {
    isUserLoggedIn.value = false;
    await auth.signOut();
    Get.close(2);
  }

  Future<void> verifyEmail() async {
    if (signupEmailFormKey.currentState!.validate()) {
      isSigningIn.value = true;

      try {
        final emailQuery = await FirebaseFirestore.instance
            .collection("Users")
            .where("email", isEqualTo: emailController.text.trim())
            .get();

        if (emailQuery.docs.isNotEmpty) {
          _emailError.value = "This email is already in use.";
          isSigningIn.value = false;
          signupEmailFormKey.currentState!.validate();
          return;
        }

        _emailError.value = null;
        Get.to(() => const SignupPasswordPage(),
            transition: Transition.rightToLeft);
      } catch (e) {
        debugPrint("Error: $e");
        isSigningIn.value = false;
      }
      isSigningIn.value = false;
    }
  }

  Future<void> verifyPassword() async {
    if (signupPasswordFormKey.currentState!.validate()) {
      debugPrint("approved");

      isSigningIn.value = true;

      try {
        _userCredential = await auth.createUserWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passwordController.text.trim());

        await sendVerificationEmail();
      } catch (e) {
        debugPrint("Error during signup: $e");
      } finally {
        isSigningIn.value = false;
      }
    }
  }

  Future<void> sendVerificationEmail() async {
    final user = auth.currentUser;

    if (user != null && !user.emailVerified) {
      try {
        await user.sendEmailVerification();
        Get.snackbar(
          "Verification Email Sent",
          "A verification email has been sent to ${user.email}. Please verify before continuing",
          snackPosition: SnackPosition.BOTTOM,
        );
        startCountdown();
      } catch (e) {
        debugPrint("Error sending verification email: $e");
      }
    }
  }

  void checkEmailVerified() {
    Timer.periodic(const Duration(seconds: 5), (Timer timer) async {
      await FirebaseAuth.instance.currentUser?.reload(); // Reload user data
      isEmailVerified.value =
          FirebaseAuth.instance.currentUser?.emailVerified ?? false;

      if (isEmailVerified.value) {
        timer.cancel(); // Stop polling
        _countdownTimer?.cancel();
        try {
          await createUserDocument();
          Get.offAll(() => const HomePage());
        } catch (e) {
          Get.snackbar(
            "Error creating user",
            "$e",
            snackPosition: SnackPosition.BOTTOM,
          );
        }
      }
    });
  }

  Future<void> createUserDocument() async {
    if (_userCredential != null && _userCredential?.user != null) {
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(_userCredential?.user!.uid)
          .set({
        'userId': _userCredential?.user!.uid,
        'email': _userCredential?.user!.email,
      });
    }
  }

  void startCountdown() {
    _countdown.value = 120;
    canResendEmail.value = false;
    _countdownTimer?.cancel();
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_countdown.value > 0) {
        _countdown.value--;
      } else {
        canResendEmail.value = true;
        timer.cancel();
      }
    });
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
    if (_emailError.value != null) {
      return _emailError.value;
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
