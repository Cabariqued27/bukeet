import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

double getResponsiveSize(double phone, double tablet, double web) {
  if (isPhone) return phone;
  if (isTablet) return tablet;
  if (isDesktop) return web;
  return 0;
}

bool get isPhone => MediaQuery.of(Get.context!).size.width < 650;

bool get isTablet =>
    MediaQuery.of(Get.context!).size.width >= 650 &&
    MediaQuery.of(Get.context!).size.width < 1100;

bool get isDesktop => MediaQuery.of(Get.context!).size.width >= 1100;
