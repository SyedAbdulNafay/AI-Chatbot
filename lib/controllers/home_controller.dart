import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomeController extends GetxController {
  var selectedTab = 1.obs;
  var shrinkOffset = 0.0.obs;
  final ScrollController scrollController = ScrollController();
  final TextEditingController searchController = TextEditingController();
  final _box = Hive.box('myThemeBox');

  Future<void> switchToLightMode() async {
    await _box.put('isDarkMode', false);
  }

  Future<void> switchToDarkMode() async {
    await _box.put('isDarkMode', true);
  }
}
