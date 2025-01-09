import 'package:ai_chatbot/controllers/profile_controller.dart';
import 'package:ai_chatbot/services/theme.dart';
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
        Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Container(
            height: 4,
            width: 40,
            decoration: BoxDecoration(
                color: Get.theme.colorScheme.tertiary,
                borderRadius: BorderRadius.circular(2)),
          ),
        ),
        ListView.builder(
          padding: EdgeInsets.symmetric(
              horizontal: layoutController.responsiveWidth(32, screenWidth)),
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
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
      ],
    );
  }
}
