import 'package:bukeet/flows/user/home/controllers/home_admin_flow.dart';
import 'package:bukeet/preferences/user_preferences.dart';
import 'package:bukeet/theme/theme.dart';
import 'package:bukeet/utils/global/log_error_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DrawerMenuController extends GetxController {
  var email = ''.obs;

  final theme = Get.find<AppTheme>();
  final _homeUserFlow = Get.find<HomeUserFlow>();
  //final _settingsFlow = Get.find<SettingsFlow>();

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  @override
  void onInit() {
    super.onInit();
    startController();
  }

  final _preferences = UserPreferences();

  void startController() {
    email.value = _preferences.getEmail();
    update();
  }

  
 
  void onEditProfile(
    VoidCallback? onCallBack,
  ) {
    try {
      //_settingsFlow.startEditProfile(
       // onCallBack: onCallBack,
      //);
      scaffoldKey.currentState?.closeEndDrawer();
    } catch (exception, stackTrace) {
      LogError.capture(exception, stackTrace, 'doCloseDrawer');
    }
  }

  void onPrivacyPolicy() {
    try {
     // _settingsFlow.startPrivacyPolicy();
      scaffoldKey.currentState?.closeEndDrawer();
    } catch (exception, stackTrace) {
      LogError.capture(exception, stackTrace, 'doCloseDrawer');
    }
  }

  void onTermsConditions() {
    try {
      //_settingsFlow.startTermsConditions();
      scaffoldKey.currentState?.closeEndDrawer();
    } catch (exception, stackTrace) {
      LogError.capture(exception, stackTrace, 'doCloseDrawer');
    }
  }

  void onHome() {
    _homeUserFlow.start();
  }
}
