import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/layout_controller.dart';

class SettingsBar extends StatelessWidget {
  final double screenHeight;
  final double screenWidth;
  final Widget leading;
  final String? trailing;
  final void Function()? onPressed;
  final bool noBorder;
  const SettingsBar({
    super.key,
    required this.screenHeight,
    required this.screenWidth,
    required this.leading,
    this.trailing,
    this.onPressed,
    required this.noBorder,
  });

  @override
  Widget build(BuildContext context) {
    final LayoutController layoutController = Get.find();

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(
            vertical: layoutController.responsiveHeight(36, screenHeight)),
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
                    color: Get.theme.colorScheme.tertiary
                        .withOpacity(noBorder ? 0 : 0.28)))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            leading,
            Row(
              children: [
                if (trailing != null)
                  Text(
                    trailing!,
                    style: TextStyle(
                      color: Get.theme.colorScheme.tertiary,
                      fontSize: 16,
                    ),
                  ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
