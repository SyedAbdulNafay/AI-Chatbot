import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/layout_controller.dart';
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
          itemCount: options.length,
          itemBuilder: (context, index) {
            return SettingsBar(
                screenHeight: screenHeight,
                screenWidth: screenWidth,
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
      ],
    );
  }
}
