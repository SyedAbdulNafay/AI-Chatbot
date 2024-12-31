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
    final HomeController homeController = Get.put(HomeController());

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
              onTap: () {
                switch (themes[index]) {
                  case "Light":
                    homeController.switchTheme();
                    Get.changeThemeMode(homeController.currentTheme.value);
                    Get.back();
                    break;
                  case "Dark":
                    homeController.switchTheme();
                    Get.changeThemeMode(homeController.currentTheme.value);
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
