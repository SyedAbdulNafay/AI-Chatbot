import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

class LayoutController extends GetxController {
  var box = Hive.box('myThemeBox');
  var isDarkMode = false.obs;
  double responsiveHeight(double pixelValue, double screenHeight) {
    return screenHeight * (pixelValue / 928);
  }

  double responsiveWidth(double pixelValue, double screenWidth) {
    return screenWidth * (pixelValue / 428);
  }

  @override
  void onInit() {
    super.onInit();
    isDarkMode.value = box.get('isDarkMode');
  }
}
