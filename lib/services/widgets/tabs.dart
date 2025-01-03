import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/home_controller.dart';
import '../../controllers/layout_controller.dart';

class Tabs extends StatelessWidget {
  final double screenWidth;
  final double screenHeight;
  const Tabs(
      {super.key, required this.screenWidth, required this.screenHeight});

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.put(HomeController());

    return Obx(() => SizedBox(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                Tab(
                  text: "Chats",
                  icon: Icon(
                    Icons.chat_outlined,
                    color: homeController.selectedTab.value == 1
                        ? Get.theme.colorScheme.surface
                        : Get.theme.colorScheme.inversePrimary,
                  ),
                  isSelected: homeController.selectedTab.value == 1,
                  screenWidth: screenWidth,
                  onTap: () {
                    homeController.selectedTab.value = 1;
                  },
                  screenHeight: screenHeight,
                ),
                Tab(
                  text: "Archived",
                  icon: Icon(
                    Icons.archive_outlined,
                    color: homeController.selectedTab.value == 2
                        ? Get.theme.colorScheme.surface
                        : Get.theme.colorScheme.inversePrimary,
                  ),
                  isSelected: homeController.selectedTab.value == 2,
                  screenWidth: screenWidth,
                  onTap: () {
                    homeController.selectedTab.value = 2;
                  },
                  screenHeight: screenHeight,
                ),
                Tab(
                  text: "Images",
                  icon: Icon(
                    Icons.image_outlined,
                    color: homeController.selectedTab.value == 3
                        ? Get.theme.colorScheme.surface
                        : Get.theme.colorScheme.inversePrimary,
                  ),
                  isSelected: homeController.selectedTab.value == 3,
                  screenWidth: screenWidth,
                  onTap: () {
                    homeController.selectedTab.value = 3;
                  },
                  screenHeight: screenHeight,
                ),
              ],
            ),
          ),
        ));
  }
}

class Tab extends StatelessWidget {
  final String text;
  final Icon icon;
  final bool isSelected;
  final double screenWidth;
  final double screenHeight;
  final void Function()? onTap;
  const Tab({
    super.key,
    required this.text,
    required this.icon,
    required this.isSelected,
    required this.screenWidth,
    required this.screenHeight,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final LayoutController layoutController = Get.find();

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
            vertical: layoutController.responsiveHeight(14, screenHeight),
            horizontal: layoutController.responsiveWidth(24, screenWidth)),
        margin: EdgeInsets.symmetric(
            horizontal: layoutController.responsiveWidth(16, screenWidth),
            vertical: layoutController.responsiveHeight(8, screenHeight)),
        decoration: BoxDecoration(
            border: Border.all(
                color: isSelected
                    ? Get.theme.colorScheme.tertiary.withOpacity(0.28)
                    : Get.theme.colorScheme.outline),
            borderRadius: BorderRadius.circular(32),
            color: isSelected
                ? Get.theme.colorScheme.inversePrimary
                : Get.theme.colorScheme.surface),
        child: Row(
          children: [
            icon,
            SizedBox(
              width: layoutController.responsiveWidth(11, screenWidth),
            ),
            Text(
              text,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: isSelected
                      ? Get.theme.colorScheme.surface
                      : Get.theme.colorScheme.tertiary),
            ),
          ],
        ),
      ),
    );
  }
}
