import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../controllers/layout_controller.dart';
import '../controllers/profile_controller.dart';
import '../services/widgets/settings_bar.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final LayoutController layoutController = Get.find();
    final ProfileController profileController = Get.put(ProfileController());

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(CupertinoIcons.back),
            color: Theme.of(context).colorScheme.inversePrimary,
            onPressed: () {
              Get.back();
            },
          ),
          title: Text(
            "Profile & Settings",
            style: TextStyle(
                color: Get.theme.colorScheme.inversePrimary,
                fontWeight: FontWeight.bold,
                fontSize: 20),
          ),
          actions: [
            Icon(
              Icons.more_vert,
              color: Get.theme.colorScheme.inversePrimary,
              size: 28,
            )
          ],
        ),
        body: LayoutBuilder(
          builder: (context, constraints) {
            double screenHeight = constraints.maxHeight;
            double screenWidth = constraints.maxWidth;

            return Center(
              child: Padding(
                padding: EdgeInsets.all(
                    layoutController.responsiveHeight(24, screenHeight)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height:
                          layoutController.responsiveHeight(24, screenHeight),
                    ),
                    Text(
                      FirebaseAuth.instance.currentUser?.displayName ??
                          "Username",
                      style: TextStyle(
                        color: Get.theme.colorScheme.inversePrimary,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "0 days until the end of the premium account",
                      style: TextStyle(
                        color: Get.theme.colorScheme.tertiary,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(
                      height:
                          layoutController.responsiveHeight(16, screenHeight),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal:
                            layoutController.responsiveWidth(16, screenWidth),
                        vertical:
                            layoutController.responsiveHeight(8, screenHeight),
                      ),
                      decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [
                            Theme.of(context).colorScheme.primary,
                            Theme.of(context).colorScheme.secondary,
                          ]),
                          borderRadius: BorderRadius.circular(25)),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SvgPicture.asset(
                            'assets/svgs/premium_diamond_vector.svg',
                            colorFilter: ColorFilter.mode(
                                Get.theme.colorScheme.surface, BlendMode.srcIn),
                            height: layoutController.responsiveHeight(
                                11.44, screenHeight),
                            width: layoutController.responsiveWidth(
                                12.67, screenWidth),
                          ),
                          SizedBox(
                            width: layoutController.responsiveWidth(
                                4, screenWidth),
                          ),
                          Text(
                            "Premium Account",
                            style: TextStyle(
                              color: Get.theme.colorScheme.surface,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height:
                          layoutController.responsiveHeight(24, screenHeight),
                    ),
                    Expanded(
                      child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: profileController.settings.length,
                        itemBuilder: (context, index) {
                          return SettingsBar(
                            screenHeight: screenHeight,
                            screenWidth: screenWidth,
                            leading: Text(
                              profileController.settings.keys.elementAt(index),
                              style: TextStyle(
                                color: Get.theme.colorScheme.inversePrimary,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            trailing: index == 1
                                ? profileController.whichTheme
                                : profileController.settings.values
                                    .elementAt(index),
                            noBorder:
                                index == profileController.settings.length - 1,
                            onPressed: () => profileController.onPressed(
                              index,
                              screenHeight: screenHeight,
                              screenWidth: screenWidth,
                            ),
                          );
                        },
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Terms of use",
                            style: TextStyle(
                                color: Get.theme.colorScheme.tertiary)),
                        SizedBox(
                            width: layoutController.responsiveWidth(
                                16, screenWidth)),
                        Text(" | ",
                            style: TextStyle(
                                color: Get.theme.colorScheme.tertiary)),
                        SizedBox(
                            width: layoutController.responsiveWidth(
                                16, screenWidth)),
                        Text("Privacy policy",
                            style: TextStyle(
                                color: Get.theme.colorScheme.tertiary)),
                      ],
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
