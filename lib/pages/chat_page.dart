import 'package:ai_chatbot/models/message.dart';
import 'package:ai_chatbot/pages/loading_animation.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../controllers/chat_controller.dart';
import '../controllers/layout_controller.dart';
import '../services/widgets/send_button.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    final LayoutController layoutController = Get.find();
    final ChatController chatController = Get.find();

    return SafeArea(
      child: LayoutBuilder(builder: (context, constraints) {
        double screenHeight = constraints.maxHeight;
        double screenWidth = constraints.maxWidth;

        return Scaffold(
          appBar: AppBar(
            backgroundColor: Get.theme.colorScheme.surface,
            leading: IconButton(
              onPressed: () {
                chatController.currentChatId = '';
                Get.back();
              },
              icon: Icon(
                CupertinoIcons.back,
                color: Get.theme.colorScheme.inversePrimary,
              ),
            ),
            title: Text(
              "Chat Bot AI 4.5",
              style: TextStyle(
                  fontFamily: "SecondHeadingFont",
                  fontSize: 20,
                  color: Get.theme.colorScheme.inversePrimary),
            ),
            actions: [
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.ios_share,
                  color: Get.theme.colorScheme.inversePrimary,
                  size: 24,
                ),
              ),
            ],
          ),
          body: Column(
            children: [
              Obx(() => chatController.messages.isEmpty
                  ? Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: layoutController.responsiveHeight(
                                screenHeight / 2, screenHeight)),
                        child: AnimatedTextKit(
                          isRepeatingAnimation: false,
                          animatedTexts: [
                            TypewriterAnimatedText(
                              'How may I help you today?',
                              textStyle: const TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                              speed: const Duration(milliseconds: 80),
                            )
                          ],
                        ),
                      ),
                    )
                  : Expanded(
                      child: ScrollConfiguration(
                        behavior:
                            const ScrollBehavior().copyWith(overscroll: false),
                        child: ListView.builder(
                          controller: chatController.scrollController,
                          itemCount: chatController.messages.length,
                          itemBuilder: (context, index) {
                            Message message = chatController.messages[index];

                            return Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: layoutController.responsiveWidth(
                                      24, screenWidth),
                                  vertical: layoutController.responsiveHeight(
                                      24, screenHeight)),
                              decoration: BoxDecoration(
                                  border: Border(
                                      top: BorderSide(
                                          color: Get.theme.colorScheme.tertiary
                                              .withOpacity(0.28)))),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      message.sentBy == "user" &&
                                              chatController.auth.currentUser
                                                      ?.photoURL !=
                                                  null
                                          ? CircleAvatar(
                                              maxRadius: 15,
                                              backgroundImage: NetworkImage(
                                                  chatController.auth
                                                      .currentUser!.photoURL!),
                                            )
                                          : Container(
                                              padding: EdgeInsets.all(
                                                  layoutController
                                                      .responsiveHeight(
                                                          10, screenHeight)),
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: message.sentBy == "user"
                                                    ? Get.theme.colorScheme
                                                        .primary
                                                    : Get.theme.colorScheme
                                                        .inversePrimary,
                                              ),
                                              child: Text(
                                                message.sentBy == "user"
                                                    ? "U"
                                                    : "A",
                                                style: TextStyle(
                                                  color: Get.theme.colorScheme
                                                      .surface,
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ),
                                      SizedBox(
                                        width: layoutController.responsiveWidth(
                                            12, screenWidth),
                                      ),
                                      Text(
                                        message.sentBy == "user"
                                            ? "You"
                                            : "Chat Bot AI 4.5",
                                        style: TextStyle(
                                          color: Get
                                              .theme.colorScheme.inversePrimary,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical:
                                            layoutController.responsiveHeight(
                                                16, screenHeight)),
                                    child: Obx(() => message.message.value ==
                                            null
                                        ? const Row(
                                            children: [
                                              LoadingAnimation(),
                                            ],
                                          )
                                        : (message.sentBy == "user"
                                            ? Text(
                                                message.message.value!,
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  color: Get.theme.colorScheme
                                                      .primary,
                                                ),
                                              )
                                            : RichText(
                                                text: TextSpan(
                                                    style: TextStyle(
                                                      color: Get
                                                          .theme
                                                          .colorScheme
                                                          .inversePrimary,
                                                      fontSize: 16,
                                                    ),
                                                    children: chatController
                                                        .parseResponse(message
                                                            .message
                                                            .value!))))),
                                  ),
                                  Row(
                                    children: [
                                      Row(
                                        children: [
                                          SvgPicture.asset(
                                            'assets/svgs/Edit-Square.svg',
                                            colorFilter: ColorFilter.mode(
                                              Get.theme.colorScheme.tertiary,
                                              BlendMode.srcIn,
                                            ),
                                          ),
                                          SizedBox(
                                            width: layoutController
                                                .responsiveWidth(
                                                    8, screenWidth),
                                          ),
                                          Text(
                                            "Edit",
                                            style: TextStyle(
                                                color: Get.theme.colorScheme
                                                    .tertiary),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        width: layoutController.responsiveWidth(
                                            24, screenWidth),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Clipboard.setData(ClipboardData(
                                                  text: message.message.value!))
                                              .then((onValue) {
                                            Get.snackbar(
                                              "Copied",
                                              "Text copied to clipboard",
                                              snackPosition:
                                                  SnackPosition.BOTTOM,
                                              backgroundColor:
                                                  Get.theme.colorScheme.surface,
                                              colorText: Get.theme.colorScheme
                                                  .inversePrimary,
                                            );
                                          });
                                        },
                                        child: Row(
                                          children: [
                                            SvgPicture.asset(
                                              'assets/svgs/Copy-Icon.svg',
                                              colorFilter: ColorFilter.mode(
                                                Get.theme.colorScheme.tertiary,
                                                BlendMode.srcIn,
                                              ),
                                            ),
                                            SizedBox(
                                              width: layoutController
                                                  .responsiveWidth(
                                                      8, screenWidth),
                                            ),
                                            Text(
                                              "Copy",
                                              style: TextStyle(
                                                  color: Get.theme.colorScheme
                                                      .tertiary),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    )),
              Padding(
                padding: EdgeInsets.only(
                  left: layoutController.responsiveWidth(24, screenWidth),
                  right: layoutController.responsiveWidth(24, screenWidth),
                  bottom: layoutController.responsiveHeight(24, screenHeight),
                ),
                child: Row(
                  children: [
                    Expanded(
                        child: TextField(
                      focusNode: chatController.focusNode,
                      onTapOutside: (event) {
                        chatController.focusNode.unfocus();
                      },
                      onChanged: (value) {
                        chatController.userPrompt.value = value;
                      },
                      controller: chatController.textController,
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
                              'assets/svgs/select-image-vector.svg',
                              colorFilter: ColorFilter.mode(
                                Get.theme.colorScheme.tertiary,
                                BlendMode.srcIn,
                              ),
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
                    Obx(() => SendButton(
                          onTap: () async {
                            await chatController.onSend();
                          },
                          disabled: chatController.userPrompt.value == "",
                        )),
                  ],
                ),
              )
            ],
          ),
        );
      }),
    );
  }
}
