import 'package:bukeet/flows/authentication/controllers/authentication_flow.dart';
import 'package:bukeet/preferences/user_preferences.dart';
import 'package:bukeet/services/providers/auth_provider.dart';
import 'package:bukeet/services/providers/user_provider.dart';
import 'package:bukeet/theme/theme.dart';
import 'package:bukeet/utils/alerts/alerts_utils.dart';
import 'package:bukeet/utils/app/app_size.dart';
import 'package:bukeet/utils/regex/validations_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum ResetPasswordState {
  login,
  createPassword,
  validateOtp,
}

class ResetPasswordController extends GetxController {
  final VoidCallback onHome;
  final AppTheme theme;

  ResetPasswordController({
    required this.onHome,
    required this.theme,
  });

  var activeNextfull = false.obs;
  var activeNextPassword = false.obs;
  var activeNextConfirm = false.obs;
  var showPassword = false.obs;
  var showConfirmPassword = false.obs;
  var emailWarning = false.obs;
  var signUpPasswordWarning = true.obs;
  var signUpConfirmPasswordWarning = true.obs;
  var activeRequestOtp = false.obs;
  var showInvalidOtpMessage = false.obs;
  var reSendOtpTime = 0.obs;

  var activeNextSendOtp = false.obs;
  var state = ResetPasswordState.login.obs;

  final dateController = TextEditingController();
  final emailOtpController = TextEditingController();

  final passwordOtpController = TextEditingController();
  final confirmPasswordOtpController = TextEditingController();
  final otpInputController = TextEditingController();

  final _authProvider = AuthProvider();
  final _usuarioProvider = UserProvider();
  final _preferences = UserPreferences();

  final _authFlow = Get.find<AuthenticationFlow>();

  void onChangedOtpForm() {
    var validEmail = ValidationUtils.validateEmail(emailOtpController.text);

    if (validEmail) {
      updateActiveNextOtp(true);
      return;
    }

    updateActiveNextOtp(false);
    return;
  }

  void onChangeOtpPassword() {
    var validPassword =
        ValidationUtils.validatePassword(passwordOtpController.text);
    var validConfirmPassword =
        ValidationUtils.validatePassword(confirmPasswordOtpController.text);
    var paswordMatch =
        passwordOtpController.text == confirmPasswordOtpController.text;

    if (!validPassword) {
      updateOtpWarningPassword(true);
    } else if (validPassword) {
      updateOtpWarningPassword(false);
    }

    if (!validConfirmPassword) {
      updateOtpWarningConfirmPassword(true);
    } else if (!paswordMatch) {
      updateOtpWarningConfirmPassword(true);
    } else if (validConfirmPassword) {
      updateOtpWarningConfirmPassword(false);
    }

    if (validPassword && validConfirmPassword) {
      if (paswordMatch) {
        updateActiveNextPassword(true);
        return;
      }
    }

    updateActiveNextPassword(false);
    return;
  }

  void updateReSendOtpTime(int value) {
    reSendOtpTime.value = value;
    update();
  }

  void updateRequestOtp(bool value) {
    activeRequestOtp.value = value;
    update();
  }

  void updateInvalidCodeMessage(bool value) {
    showInvalidOtpMessage.value = value;
    update();
  }

  void updateState(ResetPasswordState value) {
    state.value = value;
    update();
  }

  void updateActiveNextPassword(bool value) {
    activeNextPassword.value = value;
    update();
  }

  void updateActiveNextConfirm(bool value) {
    activeNextConfirm.value = value;
    update();
  }

  void updateShowPassword() {
    showPassword.value = !showPassword.value;
    update();
  }

  void updateShowConfirmPassword() {
    showConfirmPassword.value = !showConfirmPassword.value;
    update();
  }

  void updateWarningEmail(bool value) {
    emailWarning.value = value;
    update();
  }

  void updateOtpWarningPassword(bool value) {
    signUpPasswordWarning.value = value;
    update();
  }

  void updateOtpWarningConfirmPassword(bool value) {
    signUpConfirmPasswordWarning.value = value;
    update();
  }

  Future<bool> isEmailTaken(email) async {
    var isEmailTaken = await _usuarioProvider.getUserByEmail(email: email);
    if (isEmailTaken != null) {
      return true;
    }
    return false;
  }

  Future<void> onChangePassword() async {
    updateActiveNextPassword(false);

    await _authProvider.updatePassword(
      password: passwordOtpController.text,
    );

    var check = await _authProvider.signIn(
      email: emailOtpController.text,
      password: passwordOtpController.text,
    );

    if (check != null) {
      await _authProvider.updatePassword(
        password: passwordOtpController.text,
      );
      _preferences.deleteAllData();
      await _authProvider.signOut();
      _authFlow.start();
      return AlertUtils.showMessageAlert(
        title: 'password_changed'.tr,
        buttonTitle: 'close'.tr,
        onPressed: () => Get.back(),
      );
    }

    updateActiveNextPassword(true);
    AlertUtils.showMessageAlert(
      title: 'an_error_ocurred'.tr,
      buttonTitle: 'close'.tr,
      onPressed: () => Get.back(),
    );
    return;
  }

  Future<void> onValidateOtp() async {
    if (emailOtpController.text.isNotEmpty &&
        otpInputController.text.length == 6) {
      updateInvalidCodeMessage(false);

      var isValidated = await _authProvider.validateOtpForRecoverPassword(
        email: emailOtpController.text,
        code: otpInputController.text,
      );

      if (isValidated) {
        //var isUpdated = await _usuarioProvider.updateValidatedEmail(
        // email: emailSignUpController.text,
        // value: true,
        //);

        //if (isUpdated) {
        updateState(ResetPasswordState.createPassword);
        resetOtpValues();
        return;
        //}
      }

      updateInvalidCodeMessage(true);
      return;
    }
  }

  void resetOtpValues() {
    updateInvalidCodeMessage(false);
    otpInputController.clear();
    update();
  }

  void onEndOtpTime() {
    updateRequestOtp(true);
  }

  Future<void> onReSendOtpCode() async {
    updateReSendOtpTime(getOtpTime());
    updateRequestOtp(false);
    await _authProvider.requestOtpForResetPassword(
      email: emailOtpController.text,
    );
  }

  int getOtpTime() {
    int otpTime = DateTime.now().millisecondsSinceEpoch + 1000 * 60;
    return otpTime;
  }

  void updateActiveNextOtp(bool value) {
    activeNextSendOtp.value = value;
    update();
  }

  Future<void> onSendOtp() async {
    updateActiveNextOtp(false);

    var canSignUp = await isEmailTaken(emailOtpController.text);

    if (canSignUp) {
      updateActiveNextOtp(true);
      _authProvider.requestOtpForResetPassword(
        email: emailOtpController.text,
      );
      updateState(ResetPasswordState.validateOtp);
      updateReSendOtpTime(getOtpTime());
      updateActiveNextOtp(true);
      updateRequestOtp(false);
    } else {
      AlertUtils.showMessageAlert(
        title: 'user_does_not_exist_password'.tr,
        buttonTitle: 'close'.tr,
        onPressed: () => Get.back(),
      );
    }

    return;
  }

  double determineHeight() {
    if (state.value == ResetPasswordState.validateOtp) {
      return AppSize.height() * 0.44;
    } else if (state.value == ResetPasswordState.createPassword) {
      return AppSize.height() * 0.56;
    } else if (state.value == ResetPasswordState.login) {
      return AppSize.height() * 0.4;
    }

    return AppSize.height() * 0;
  }
}
