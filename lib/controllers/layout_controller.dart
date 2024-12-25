import 'package:get/get.dart';

class LayoutController extends GetxController {
  double responsiveHeight(double pixelValue, double screenHeight) {
    return screenHeight * (pixelValue / 928);
  }

  double responsiveWidth(double pixelValue, double screenWidth) {
    return screenWidth * (pixelValue / 428);
  }
}
