import 'package:bukeet/utils/global/size_device_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppSize {
  static double width() =>
      getResponsiveSize(MediaQuery.of(Get.context!).size.width, 450, 370);

  static double height() => getResponsiveSize(
      MediaQuery.of(Get.context!).size.height,
      MediaQuery.of(Get.context!).size.height * 0.85,
      MediaQuery.of(Get.context!).size.height * 0.85);

  static double menuHeight() => getResponsiveSize(
      MediaQuery.of(Get.context!).size.height * 0.14,
      MediaQuery.of(Get.context!).size.height * 0.14,
      MediaQuery.of(Get.context!).size.height * 0.14);
}
