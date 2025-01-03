import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomeController extends GetxController {
  Rx<ThemeMode> currentTheme =
      Get.isDarkMode ? ThemeMode.dark.obs : ThemeMode.light.obs;
  var selectedTab = 1.obs;
  var shrinkOffset = 0.0.obs;
  final ScrollController scrollController = ScrollController();
  final TextEditingController searchController = TextEditingController();
  var box = Hive.box('myThemeBox');

  Future<void> switchToLightMode() async {
    await box.put('isDarkMode', false);
  }

  Future<void> switchToDarkMode() async {
    await box.put('isDarkMode', true);
  }
}
