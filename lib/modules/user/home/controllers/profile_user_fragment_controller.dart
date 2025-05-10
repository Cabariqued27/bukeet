import 'package:bukeet/flows/authentication/controllers/authentication_flow.dart';
import 'package:bukeet/preferences/user_preferences.dart';
import 'package:bukeet/services/providers/auth_provider.dart';
import 'package:bukeet/services/providers/user_provider.dart';
import 'package:bukeet/theme/theme.dart';
import 'package:bukeet/utils/alerts/alerts_utils.dart';
import 'package:bukeet/utils/global/log_error_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileUserFragmentController extends GetxController {
  final AppTheme theme;
  //final Function(String) onClick;

  ProfileUserFragmentController({
    required this.theme,
    //required this.onClick,
  });

  final _userPreferences = UserPreferences();
  final _userProvider = UserProvider();
  final _authProvider = AuthProvider();
  final _authFlow = Get.find<AuthenticationFlow>();

  var date = ''.obs;

  final firstNameInputController = TextEditingController();
  final lastNameInputController = TextEditingController();
  final emailNameInputController = TextEditingController();

  void startController() {
    loadingData();
    loadingRegisterAt();
  }

  void loadingData() {
    firstNameInputController.text = _userPreferences.getFirstName();
    lastNameInputController.text = _userPreferences.getLastName();
    emailNameInputController.text = _userPreferences.getEmail();
    update();
  }

  Future<void> loadingRegisterAt() async {
    var registerAt = await _userProvider.getUserByEmail(
        email: emailNameInputController.text);

    var dateStr = registerAt?.registerAt;

    if (dateStr != null) {
      try {
        var date = DateTime.parse(dateStr);
        updateDate('${date.month}.${date.day}.${date.year}');
      } catch (exception, stackTrace) {
        LogError.capture(exception, stackTrace, 'loadingRegisterAt');
      }
    }
  }

  void updateDate(String value) {
    date.value = value;
  }

  void logOut() {
    AlertUtils.showSingleAlert(
      title: 'exit'.tr,
      negativeTitle: 'ok'.tr,
      positiveTitle: 'cancel'.tr,
      positiveAction: () => Get.back(),
      negativeAction: () async {
        _userPreferences.deleteAllData();
        await _authProvider.signOut();
        _authFlow.start();
      },
      barrierDismissible: false,
    );
  }
}
