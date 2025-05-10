import 'package:bukeet/theme/theme.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:get/get.dart';

class SliderNetworkImageController extends GetxController {
  final List<dynamic> images;

  var sliderController = CarouselController();
  var current = 1.obs;
  var isLoadData = false.obs;

  SliderNetworkImageController(this.images);

  @override
  void onInit() {
    super.onInit();
    startController();
  }

  var theme = Get.find<AppTheme>();

  void startController() {
    if (images.isNotEmpty) {
      isLoadData.value = true;
      update();
    }
  }

  void animateToPage(int value) {
  current.value = value;
  update(); 
}

}
