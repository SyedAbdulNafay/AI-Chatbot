import 'package:ai_chatbot/pages/profile_page.dart';
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
    final HomeController homeController = Get.put(HomeController());

    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(builder: (context, constraints) {
          double screenWidth = constraints.maxWidth;
          double screenHeight = constraints.maxHeight;

          return CustomScrollView(
            controller: homeController.scrollController,
            slivers: [
              SliverAppBar(
                backgroundColor: Get.theme.colorScheme.surface,
                expandedHeight: 255,
                flexibleSpace: FlexibleSpaceBar(
                  background: Padding(
                    padding: EdgeInsets.only(
                      left: layoutController.responsiveWidth(24, screenWidth),
                      right: layoutController.responsiveWidth(24, screenWidth),
                      top: layoutController.responsiveWidth(12, screenWidth),
                      bottom: layoutController.responsiveWidth(32, screenWidth),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                              onTap: () => Get.to(
                                () => const ProfilePage(),
                                transition: Transition.rightToLeft,
                              ),
                              child: Container(
                                padding: const EdgeInsets.all(3),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Get.theme.colorScheme.tertiary
                                        .withOpacity(0.28)),
                                child: Icon(
                                  Icons.person,
                                  color: Get.theme.colorScheme.tertiary,
                                  size: 40,
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: layoutController.responsiveHeight(
                              12, screenHeight),
                        ),
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
                  color: Get.theme.colorScheme.tertiary.withOpacity(0.28),
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
              SliverCrossAxisGroup(
                slivers: [
                  SliverList.builder(
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(
                          left:
                              layoutController.responsiveWidth(8, screenWidth),
                          right:
                              layoutController.responsiveWidth(4, screenWidth),
                          top: layoutController.responsiveHeight(
                              8, screenHeight),
                        ),
                        child: ChatCard(
                          screenHeight: screenHeight,
                          screenWidth: screenWidth,
                          chatTitle: "How can I forget a bad memory?",
                          content:
                              "Forgetting a bad memory entirely may be challenging, as memories are complex and deeply ingrained into the mind.",
                          time: "28 mins ago",
                        ),
                      );
                    },
                  ),
                  SliverList.builder(
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(
                          right:
                              layoutController.responsiveWidth(8, screenWidth),
                          left:
                              layoutController.responsiveWidth(4, screenWidth),
                          top: layoutController.responsiveHeight(
                              8, screenHeight),
                        ),
                        child: ChatCard(
                          screenHeight: screenHeight,
                          screenWidth: screenWidth,
                          chatTitle: "How can I forget a bad memory?",
                          content:
                              "Forgetting a bad memory entirely may be challenging, as memories are complex and deeply ingrained into the mind.",
                          time: "28 mins ago",
                        ),
                      );
                    },
                  ),
                ],
              )
            ],
          );
        }),
      ),
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
