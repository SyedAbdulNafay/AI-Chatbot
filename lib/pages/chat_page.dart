import 'package:ai_chatbot/controllers/login_controller.dart';
import 'package:ai_chatbot/services/widgets/send_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    final LoginController loginController = Get.put(LoginController());

    return SafeArea(
      child: LayoutBuilder(builder: (context, constraints) {
        double screenHeight = constraints.maxHeight;
        double screenWidth = constraints.maxWidth;

        return Scaffold(
          appBar: AppBar(
            backgroundColor: Get.theme.colorScheme.surface,
            leading: IconButton(
              onPressed: () {},
              icon: Icon(
                CupertinoIcons.back,
                color: Get.theme.colorScheme.inversePrimary,
              ),
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Get.theme.colorScheme.inversePrimary,
                      ),
                      child: Icon(
                        Icons.gamepad,
                        color: Get.theme.colorScheme.surface,
                        size: 25,
                      ),
                    ),
                    SizedBox(
                      width: loginController.responsiveWidth(16, screenWidth),
                    ),
                    Text(
                      "Chat Bot AI 4.5",
                      style: TextStyle(
                          fontFamily: "SecondHeadingFont",
                          fontSize: 20,
                          color: Get.theme.colorScheme.inversePrimary),
                    )
                  ],
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.ios_share,
                    color: Get.theme.colorScheme.tertiary,
                    size: 24,
                  ),
                ),
              ],
            ),
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: loginController.responsiveWidth(24, screenWidth)),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                        child: TextField(
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                          horizontal:
                              loginController.responsiveWidth(24, screenWidth),
                          vertical: loginController.responsiveHeight(
                              16, screenHeight),
                        ),
                        suffixIcon: IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.image_outlined,
                              color: Get.theme.colorScheme.tertiary,
                            )),
                        hintText: "Ask me anything...",
                        hintStyle:
                            TextStyle(color: Get.theme.colorScheme.tertiary),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(
                            color: Get.theme.colorScheme.tertiary
                                .withOpacity(0.28),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(
                            color: Get.theme.colorScheme.tertiary
                                .withOpacity(0.28),
                          ),
                        ),
                      ),
                    )),
                    SizedBox(
                      width: loginController.responsiveWidth(12, screenWidth),
                    ),
                    const SendButton()
                  ],
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}
