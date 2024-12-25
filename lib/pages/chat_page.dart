import 'package:ai_chatbot/controllers/chat_controller.dart';
import 'package:ai_chatbot/controllers/layout_controller.dart';
import 'package:ai_chatbot/services/widgets/send_button.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    final LayoutController layoutController = Get.put(LayoutController());
    final ChatController chatController = Get.put(ChatController());

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
                      width: layoutController.responsiveWidth(16, screenWidth),
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
            padding: EdgeInsets.only(
              left: layoutController.responsiveWidth(24, screenWidth),
              right: layoutController.responsiveWidth(24, screenWidth),
              bottom: layoutController.responsiveHeight(24, screenHeight),
            ),
            child: Column(
              children: [
                Expanded(
                    child: ListView.builder(
                  itemCount: chatController.value.value,
                  itemBuilder: (context, index) {
                    return Container(
                      height: 100,
                      width: 100,
                      color: Get.theme.colorScheme.primary,
                    );
                  },
                )),
                // AnimatedTextKit(
                //   isRepeatingAnimation: false,
                //   animatedTexts: [
                //     TypewriterAnimatedText(
                //       'How may I help you today?',
                //       textStyle: const TextStyle(
                //         fontSize: 25,
                //         fontWeight: FontWeight.bold,
                //       ),
                //       speed: const Duration(milliseconds: 50),
                //     )
                //   ],
                // ),
                Row(
                  children: [
                    Expanded(
                        child: TextField(
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                          horizontal:
                              layoutController.responsiveWidth(24, screenWidth),
                          vertical: layoutController.responsiveHeight(
                              16, screenHeight),
                        ),
                        suffixIcon: IconButton(
                            onPressed: () {},
                            icon: SvgPicture.asset(
                              'assets/svgs/select_image_vector.svg',
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
                      width: layoutController.responsiveWidth(12, screenWidth),
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
