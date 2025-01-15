import 'package:ai_chatbot/controllers/auth_controller.dart';
import 'package:ai_chatbot/controllers/chat_controller.dart';
import 'package:ai_chatbot/pages/profile_page.dart';
import 'package:ai_chatbot/services/widgets/shimmer_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';
import '../controllers/layout_controller.dart';
import '../services/widgets/chat_card.dart';
import '../services/widgets/gradient_text.dart';
import '../services/widgets/tabs.dart';
import 'chat_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final LayoutController layoutController = Get.find();
    final AuthController authController = Get.find();
    final HomeController homeController = Get.put(HomeController());
    final ChatController chatController = Get.put(ChatController());

    return SafeArea(
      child: Scaffold(
        body: LayoutBuilder(builder: (context, constraints) {
          double screenWidth = constraints.maxWidth;
          double screenHeight = constraints.maxHeight;

          return CustomScrollView(
            controller: homeController.scrollController,
            slivers: [
              SliverAppBar(
                backgroundColor: Get.theme.colorScheme.surface,
                expandedHeight: 210,
                flexibleSpace: FlexibleSpaceBar(
                  background: Padding(
                    padding: EdgeInsets.only(
                      left: layoutController.responsiveWidth(24, screenWidth),
                      right: layoutController.responsiveWidth(24, screenWidth),
                      top: layoutController.responsiveWidth(24, screenWidth),
                      bottom: layoutController.responsiveWidth(32, screenWidth),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Start a new chat",
                          style: TextStyle(
                              fontFamily: "HeadingFont", fontSize: 35),
                        ),
                        const Text(
                          "With",
                          style: TextStyle(
                              fontFamily: "HeadingFont", fontSize: 35),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GradientText(
                              text: 'Chatbot AI',
                              gradient: LinearGradient(
                                  colors: [
                                    Theme.of(context).colorScheme.primary,
                                    Get.theme.colorScheme.secondary,
                                  ],
                                  begin: Alignment.bottomLeft,
                                  end: Alignment.topRight),
                              style: const TextStyle(
                                  fontFamily: 'HeadingFont', fontSize: 35),
                            ),
                            GestureDetector(
                              onTap: () => Get.to(() => const ChatPage()),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: layoutController.responsiveWidth(
                                      24, screenWidth),
                                  vertical: layoutController.responsiveHeight(
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
                                    Icon(Icons.add,
                                        color: Get.theme.colorScheme.surface),
                                    SizedBox(
                                      width: layoutController.responsiveWidth(
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
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Divider(
                  color: Get.theme.colorScheme.tertiary.withOpacity(
                      layoutController.isDarkMode.value ? 1 : 0.28),
                ),
              ),
              SliverPersistentHeader(
                  pinned: true,
                  delegate: _PinnedHeaderDelegate(
                    child: Column(
                      children: [
                        Container(
                          color: Get.theme.colorScheme.surface,
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: layoutController.responsiveWidth(
                                  24, screenWidth),
                              right: layoutController.responsiveWidth(
                                  24, screenWidth),
                              top: layoutController.responsiveWidth(
                                  32, screenWidth),
                              bottom: layoutController.responsiveWidth(
                                  8, screenWidth),
                            ),
                            child: Row(
                              children: [
                                const Text(
                                  "History",
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontFamily: 'SecondHeadingFont'),
                                ),
                                SizedBox(
                                  width: layoutController.responsiveWidth(
                                      16, screenWidth),
                                ),
                                Expanded(
                                  child: TextField(
                                    controller: homeController.searchController,
                                    decoration: InputDecoration(
                                      suffixIcon: GestureDetector(
                                        onTap: () => Get.to(
                                          () => const ProfilePage(),
                                          transition: Transition.rightToLeft,
                                        ),
                                        child: authController.auth.currentUser
                                                    ?.photoURL !=
                                                null
                                            ? Padding(
                                                padding: const EdgeInsets.only(
                                                  top: 1,
                                                  bottom: 1,
                                                  right: 12,
                                                ),
                                                child: CircleAvatar(
                                                  backgroundImage: NetworkImage(
                                                      authController
                                                          .auth
                                                          .currentUser!
                                                          .photoURL!),
                                                ),
                                              )
                                            : Container(
                                                margin: const EdgeInsets.only(
                                                  top: 1,
                                                  bottom: 1,
                                                  right: 12,
                                                ),
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Get.theme.colorScheme
                                                        .tertiary
                                                        .withOpacity(0.28)),
                                                child: Icon(
                                                  Icons.person,
                                                  color: Get.theme.colorScheme
                                                      .tertiary,
                                                ),
                                              ),
                                      ),
                                      hintStyle: TextStyle(
                                          color: Get.theme.colorScheme.tertiary,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                      hintText: "Search...",
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Get
                                                  .theme.colorScheme.tertiary
                                                  .withOpacity(0.28)),
                                          borderRadius:
                                              BorderRadius.circular(32)),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(32),
                                          borderSide: BorderSide(
                                              color: Get
                                                  .theme.colorScheme.tertiary
                                                  .withOpacity(0.28))),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Tabs(
                          screenWidth: screenWidth,
                          screenHeight: screenHeight,
                        ),
                      ],
                    ),
                  )),
              Obx(() => SliverCrossAxisGroup(
                    slivers: [
                      SliverList.builder(
                        itemCount: chatController.isLoadingChats.value
                            ? 6
                            : chatController.chats.length,
                        itemBuilder: (context, index) {
                          if (index % 2 == 1) return const SizedBox();
                          return Padding(
                            padding: EdgeInsets.only(
                              left: layoutController.responsiveWidth(
                                  8, screenWidth),
                              right: layoutController.responsiveWidth(
                                  4, screenWidth),
                              top: layoutController.responsiveHeight(
                                  8, screenHeight),
                            ),
                            child: chatController.isLoadingChats.value
                                ? ShimmerContainer(
                                    screenHeight: screenHeight,
                                    screenWidth: screenWidth,
                                  )
                                : ChatCard(
                                    onTap: () {
                                      chatController.currentChatId =
                                          chatController.chats[index].chatId;
                                      chatController.messages.value =
                                          chatController.chats[index].messages;
                                      Get.to(() => const ChatPage());
                                    },
                                    screenHeight: screenHeight,
                                    screenWidth: screenWidth,
                                    chat: chatController.chats[index],
                                  ),
                          );
                        },
                      ),
                      SliverList.builder(
                        itemCount: chatController.isLoadingChats.value
                            ? 6
                            : chatController.chats.length,
                        itemBuilder: (context, index) {
                          if (index % 2 == 0) return const SizedBox();
                          return Padding(
                            padding: EdgeInsets.only(
                              right: layoutController.responsiveWidth(
                                  8, screenWidth),
                              left: layoutController.responsiveWidth(
                                  4, screenWidth),
                              top: layoutController.responsiveHeight(
                                  8, screenHeight),
                            ),
                            child: chatController.isLoadingChats.value
                                ? ShimmerContainer(
                                    screenHeight: screenHeight,
                                    screenWidth: screenWidth,
                                  )
                                : ChatCard(
                                    screenHeight: screenHeight,
                                    screenWidth: screenWidth,
                                    chat: chatController.chats[index]),
                          );
                        },
                      ),
                    ],
                  ))
            ],
          );
        }),
        floatingActionButton: Obx(() => Opacity(
              opacity: (homeController.shrinkOffset.value) / (170.0),
              child: GestureDetector(
                onTap: () {},
                child: Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Get.theme.colorScheme.primary,
                  ),
                  child: Icon(
                    Icons.add,
                    color: Get.theme.colorScheme.surface,
                    size: 42,
                  ),
                ),
              ),
            )),
      ),
    );
  }
}

class _PinnedHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;

  _PinnedHeaderDelegate({required this.child});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final HomeController homeController = Get.find();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      homeController.shrinkOffset.value = shrinkOffset;
    });

    return Material(
      color: Colors.transparent,
      elevation: overlapsContent ? 10 : 0,
      child: child,
    );
  }

  @override
  double get maxExtent => 170.0;

  @override
  double get minExtent => 170.0;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
