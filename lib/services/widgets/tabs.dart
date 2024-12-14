import 'package:ai_chatbot/controllers/home_controller.dart';
import 'package:ai_chatbot/controllers/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
    final LoginController loginController = Get.find();
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
            vertical: loginController.responsiveHeight(14, screenHeight),
            horizontal: loginController.responsiveWidth(24, screenWidth)),
        margin: EdgeInsets.symmetric(
            horizontal: loginController.responsiveWidth(24, screenWidth)),
        decoration: BoxDecoration(
            border: Border.all(
                color: isSelected
                    ? Get.theme.colorScheme.tertiary.withOpacity(0.28)
                    : Get.theme.colorScheme.inversePrimary),
            borderRadius: BorderRadius.circular(32),
            color: isSelected
                ? Get.theme.colorScheme.inversePrimary
                : Get.theme.colorScheme.surface),
        child: Row(
          children: [
            icon,
            SizedBox(
              width: loginController.responsiveWidth(11, screenWidth),
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
