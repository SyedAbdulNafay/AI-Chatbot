import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  Rx<ThemeMode> currentTheme = ThemeMode.system.obs;
  var selectedTab = 1.obs;
  var shrinkOffset = 0.0.obs;
  final ScrollController scrollController = ScrollController();
  final TextEditingController searchController = TextEditingController();

  void switchTheme() {
    currentTheme.value = currentTheme.value == ThemeMode.light
        ? ThemeMode.dark
        : ThemeMode.light;
  }
}
