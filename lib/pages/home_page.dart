import 'package:ai_chatbot/controllers/login_controller.dart';
import 'package:ai_chatbot/services/widgets/gradient_text.dart';
import 'package:ai_chatbot/services/widgets/tabs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final LoginController loginController = Get.put(LoginController());

    return Scaffold(
      backgroundColor: Get.theme.colorScheme.surface,
      body: SafeArea(
        child: LayoutBuilder(builder: (context, constraints) {
          double screenWidth = constraints.maxWidth;
          double screenHeight = constraints.maxHeight;

          return Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  left: loginController.responsiveWidth(24, screenWidth),
                  right: loginController.responsiveWidth(24, screenWidth),
                  top: loginController.responsiveWidth(24, screenWidth),
                  bottom: loginController.responsiveWidth(32, screenWidth),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Start a new chat",
                      style: TextStyle(fontFamily: "HeadingFont", fontSize: 35),
                    ),
                    const Text(
                      "With",
                      style: TextStyle(fontFamily: "HeadingFont", fontSize: 35),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GradientText(
                          text: 'Chatbot AI',
                          gradient: LinearGradient(
                              colors: [
                                Get.theme.colorScheme.primary,
                                Get.theme.colorScheme.secondary,
                              ],
                              begin: Alignment.bottomLeft,
                              end: Alignment.topRight),
                          style: const TextStyle(
                              fontFamily: 'HeadingFont', fontSize: 35),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: loginController.responsiveWidth(
                                24, screenWidth),
                            vertical: loginController.responsiveHeight(
                                18, screenHeight),
                          ),
                          decoration: BoxDecoration(
                              color: Get.theme.colorScheme.primary,
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(36),
                                  topRight: Radius.circular(36),
                                  bottomLeft: Radius.circular(36),
                                  bottomRight: Radius.circular(8))),
                          child: Row(
                            children: [
                              const Icon(Icons.add),
                              SizedBox(
                                width: loginController.responsiveWidth(
                                    4, screenWidth),
                              ),
                              Text(
                                "New Topic",
                                style: TextStyle(
                                    color: Get.theme.colorScheme.surface,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Divider(
                color: Get.theme.colorScheme.tertiary.withOpacity(0.28),
                thickness: 1,
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: loginController.responsiveWidth(24, screenWidth),
                  right: loginController.responsiveWidth(24, screenWidth),
                  top: loginController.responsiveWidth(32, screenWidth),
                  bottom: loginController.responsiveWidth(24, screenWidth),
                ),
                child: Row(
                  children: [
                    const Text(
                      "History",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: loginController.responsiveWidth(16, screenWidth),
                    ),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          suffixIcon: Icon(
                            Icons.search,
                            color: Get.theme.colorScheme.tertiary,
                          ),
                          hintStyle: TextStyle(
                              color: Get.theme.colorScheme.tertiary,
                              fontSize: 16,
                              fontWeight: FontWeight.w700),
                          hintText: "Search...",
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Get.theme.colorScheme.tertiary
                                      .withOpacity(0.28)),
                              borderRadius: BorderRadius.circular(32)),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(32),
                              borderSide: BorderSide(
                                  color: Get.theme.colorScheme.tertiary
                                      .withOpacity(0.28))),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Tabs(
                screenWidth: screenWidth,
                screenHeight: screenHeight,
              )
            ],
          );
        }),
      ),
    );
  }
}
