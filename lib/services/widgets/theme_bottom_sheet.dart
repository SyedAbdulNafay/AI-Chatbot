import 'package:ai_chatbot/controllers/profile_controller.dart';
import 'package:ai_chatbot/services/theme.dart';
import 'package:ai_chatbot/services/widgets/bottom_sheet_clipper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/home_controller.dart';
import '../../controllers/layout_controller.dart';
import 'settings_bar.dart';

class ThemeBottomSheet extends StatelessWidget {
  final List<String> themes;
  final double screenHeight;
  final double screenWidth;
  const ThemeBottomSheet(
      {super.key,
      required this.themes,
      required this.screenHeight,
      required this.screenWidth});

  @override
  Widget build(BuildContext context) {
    final LayoutController layoutController = Get.find();
    final HomeController homeController = Get.find();
    final ProfileController profileController = Get.find();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            ClipPath(
              clipper: BottomSheetClipper(),
              child: Container(
                height: 16,
                color: Get.theme.colorScheme.surface,
              ),
            ),
            Container(
              height: 4,
              width: 39,
              decoration: BoxDecoration(
                color: Get.theme.colorScheme.surface,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ],
        ),
        Container(
          color: Get.theme.colorScheme.surface,
          child: ListView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.symmetric(
                horizontal: layoutController.responsiveWidth(32, screenWidth)),
            physics: const NeverScrollableScrollPhysics(),
            itemCount: themes.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () async {
                  switch (themes[index]) {
                    case "Light":
                      profileController.whichTheme = "Light";
                      Get.changeTheme(CustomTheme.lightTheme);
                      layoutController.isDarkMode.value = false;
                      await homeController.switchToLightMode();
                      Get.back();
                      break;
                    case "Dark":
                      profileController.whichTheme = "Dark";
                      Get.changeTheme(CustomTheme.darkTheme);
                      layoutController.isDarkMode.value = true;
                      await homeController.switchToDarkMode();
                      Get.back();
                      break;
                    default:
                  }
                },
                child: SettingsBar(
                    screenHeight: screenHeight,
                    screenWidth: screenWidth,
                    leading: Text(
                      themes[index],
                      style: TextStyle(
                        color: Get.theme.colorScheme.inversePrimary,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    noBorder: index == themes.length - 1),
              );
            },
          ),
        ),
      ],
    );
  }
}
