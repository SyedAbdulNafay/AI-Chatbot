import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../services/widgets/email_bottom_sheet.dart';
import '../services/widgets/theme_bottom_sheet.dart';

class ProfileController extends GetxController {
  Map<String, String?> settings = {
    "Email": FirebaseAuth.instance.currentUser?.email ?? "",
    "Theme": "System Default",
    "Data & Storage": "0% Used",
    "Change Password": null,
    "Send feedback": null,
  };

  List<String> themes = [
    "System Default",
    "Light",
    "Dark",
  ];

  List<String> options = [
    "Delete Account",
    "Sign Out",
  ];

  void onPressed(int index,
      {required double screenHeight, required double screenWidth}) {
    switch (index) {
      case 0:
        openEmailBottomSheet(
            screenHeight: screenHeight, screenWidth: screenWidth);
        break;
      case 1:
        openThemeBottomSheet(screenHeight, screenWidth);
        break;
      default:
    }
  }

  Future<void> openThemeBottomSheet(
      double screenHeight, double screenWidth) async {
    // i have to tweak the design of the bottom sheet, for now making it simple
    await Get.bottomSheet(
      backgroundColor: Get.theme.colorScheme.surface,
      ThemeBottomSheet(
        themes: themes,
        screenHeight: screenHeight,
        screenWidth: screenWidth,
      ),
    );
  }

  Future<void> openEmailBottomSheet({
    required double screenHeight,
    required double screenWidth,
  }) async {
    await Get.bottomSheet(
        EmailBottomSheet(
          screenWidth: screenWidth,
          screenHeight: screenHeight,
          options: options,
        ),
        backgroundColor: Get.theme.colorScheme.surface);
  }
}
