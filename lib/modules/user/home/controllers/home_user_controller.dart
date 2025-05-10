import 'package:bukeet/theme/theme.dart';
import 'package:bukeet/utils/global/log_error_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeUserController extends GetxController {
  final AppTheme theme;
  final int? initialPage;
  //final Function(String) onClick;

  HomeUserController({
    required this.theme,
    //required this.onClick,
    this.initialPage,
  });

  var currentPage = 0.obs;
  var isOpenMenu = true.obs;

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  void startController() {
    if (initialPage != null) {
      changePage(value: initialPage ?? 0);
    }
  }

  void changePage({
    required int value,
  }) {
    try {
      FocusManager.instance.primaryFocus?.unfocus();
      currentPage.value = value;
      update();

      if (value == 1) {
        //onClick(ClickEventEnum.reservations);
      } else if (value == 2) {
        //onClick(ClickEventEnum.profile);
      }
    } catch (exception, stackTrace) {
      LogError.capture(exception, stackTrace, 'changePage');
    }
  }

  void updateOpenMenu(bool value) {
    isOpenMenu.value = value;
    update();
  }

  void doCloseDrawer() {
    try {
      scaffoldKey.currentState?.closeDrawer();
    } catch (exception, stackTrace) {
      LogError.capture(exception, stackTrace, 'doCloseDrawer');
    }
  }
}
