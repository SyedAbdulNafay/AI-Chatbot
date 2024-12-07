import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final HomeController _controller = Get.put(HomeController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Obx(
          () => Text(_controller.currentTheme.value == ThemeMode.dark
              ? "Dark Theme"
              : "Light Theme"),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Tap on the switch to change the Theme",
              style: TextStyle(
                  fontSize: size.height * 0.02,
                  color: Get.theme.colorScheme.primary),
            ),
            Obx(
              () => Switch(
                value: _controller.currentTheme.value == ThemeMode.dark,
                onChanged: (value) {
                  _controller.switchTheme();
                  Get.changeThemeMode(_controller.currentTheme.value);
                },
                activeColor: Get.theme.colorScheme.primary,
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
