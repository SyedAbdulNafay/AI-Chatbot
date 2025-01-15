import 'dart:math';

import 'package:ai_chatbot/controllers/layout_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerContainer extends StatelessWidget {
  final double screenHeight;
  final double screenWidth;
  const ShimmerContainer({
    super.key,
    required this.screenHeight,
    required this.screenWidth,
  });

  @override
  Widget build(BuildContext context) {
    final LayoutController layoutController = Get.find();
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: layoutController.responsiveHeight(32, screenHeight),
        horizontal: layoutController.responsiveWidth(24, screenWidth),
      ),
      width: double.maxFinite,
      decoration: BoxDecoration(
          color: Get.theme.colorScheme.tertiary.withOpacity(0.28),
          borderRadius: BorderRadius.circular(36),
          border: Border.all(
            color: Get.theme.colorScheme.tertiary.withOpacity(0.28),
          )),
      child: Shimmer.fromColors(
        baseColor: Get.theme.colorScheme.tertiary.withOpacity(0.28),
        highlightColor: Get.theme.colorScheme.primary,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(
                  bottom: layoutController.responsiveHeight(12, screenHeight)),
              color: Get.theme.colorScheme.surface,
              width: double.maxFinite,
              height: 16,
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: 5,
              itemBuilder: (context, index) {
                return Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.only(top: 5),
                    color: Get.theme.colorScheme.surface,
                    height: 16,
                    width: Random().nextInt(150) + 50,
                  ),
                );
              },
            ),
            Container(
              margin: EdgeInsets.only(
                  top: layoutController.responsiveHeight(12, screenHeight)),
              color: Get.theme.colorScheme.surface,
              height: 14,
              width: 100,
            )
          ],
        ),
      ),
    );
  }
}
