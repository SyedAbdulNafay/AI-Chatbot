import 'package:ai_chatbot/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/layout_controller.dart';
import 'bottom_sheet_clipper.dart';
import 'settings_bar.dart';

class EmailBottomSheet extends StatelessWidget {
  final double screenWidth;
  final double screenHeight;
  final List<String> options;
  const EmailBottomSheet({
    super.key,
    required this.screenWidth,
    required this.screenHeight,
    required this.options,
  });

  @override
  Widget build(BuildContext context) {
    final LayoutController layoutController = Get.find();
    final AuthController authController = Get.find();

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
              width: 38,
              decoration: BoxDecoration(
                  color: Get.theme.colorScheme.surface,
                  borderRadius: BorderRadius.circular(10)),
            ),
          ],
        ),
        Container(
          color: Get.theme.colorScheme.surface,
          child: ListView.builder(
            padding: EdgeInsets.symmetric(
                horizontal: layoutController.responsiveWidth(32, screenWidth)),
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: options.length,
            itemBuilder: (context, index) {
              return SettingsBar(
                  screenHeight: screenHeight,
                  screenWidth: screenWidth,
                  onPressed: () async {
                    await authController.signOut();
                  },
                  leading: Text(
                    options[index],
                    style: TextStyle(
                      color: index == options.length - 1
                          ? Colors.red
                          : Get.theme.colorScheme.inversePrimary,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  noBorder: index == options.length - 1);
            },
          ),
        ),
      ],
    );
  }
}
