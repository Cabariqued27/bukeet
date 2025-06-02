import 'package:bukeet/flows/authentication/controllers/authentication_flow.dart';
import 'package:bukeet/preferences/user_preferences.dart';
import 'package:bukeet/services/models/user.dart';
import 'package:bukeet/services/providers/auth_provider.dart';
import 'package:bukeet/services/providers/user_provider.dart';
import 'package:bukeet/theme/theme.dart';
import 'package:bukeet/utils/alerts/alerts_utils.dart';
import 'package:bukeet/utils/app/app_size.dart';
import 'package:bukeet/utils/app/get_phone_type_utils.dart';
import 'package:bukeet/utils/global/date_parse_utils.dart';
import 'package:bukeet/utils/global/log_error_utils.dart';
import 'package:bukeet/utils/regex/validations_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum GetStartedLoginSignUpState {
  getStarted,
  login,
  registerEmail,
  createPassword,
  validateOtp,
}

class AuthenticationController extends GetxController {
  final VoidCallback onUserHome;
  final VoidCallback onAdminHome;
  final VoidCallback onFieldOwnerHome;
  final AppTheme theme;

  AuthenticationController({
    required this.onUserHome,
    required this.onAdminHome,
    required this.onFieldOwnerHome,
    required this.theme,
  });

  var activeNextfull = false.obs;
  var activeNextPassword = false.obs;
  var activeNextConfirm = false.obs;
  var showPassword = false.obs;
  var showConfirmPassword = false.obs;
  var firstNameWarning = false.obs;
  var emailWarning = false.obs;
  var signUpPasswordWarning = true.obs;
  var signUpConfirmPasswordWarning = true.obs;
  var activeRequestOtp = false.obs;
  var showInvalidOtpMessage = false.obs;
  var reSendOtpTime = 0.obs;

  var activeNextLogin = false.obs;
  var showPasswordLogin = false.obs;
  var state = GetStartedLoginSignUpState.getStarted.obs;
  var selectedGender = ''.obs;
  final List<String> genders = ['Masculino', 'Femenino', 'Otro'];
  var selectedUserType = ''.obs;
  final List<String> userTypes = ['Jugador', 'Propietario'];

  final dateController = TextEditingController();
  final emailLoginController = TextEditingController();
  final passwordLoginController = TextEditingController();

  final firstNameInputController = TextEditingController();
  final emailSignUpController = TextEditingController();
  final passwordSignUpController = TextEditingController();
  final confirmPasswordSignUpController = TextEditingController();
  final otpInputController = TextEditingController();

  final _authProvider = AuthProvider();
  final _usuarioProvider = UserProvider();
  final _preferences = UserPreferences();

  final _authFlow = Get.find<AuthenticationFlow>();

  void onChangedLoginForm() {
    var validEmail = ValidationUtils.validateEmail(emailLoginController.text);
    var validPassword = ValidationUtils.validatePassword(
      passwordLoginController.text,
    );

    if (validEmail && validPassword) {
      updateActiveNextLogin(true);
      return;
    }

    updateActiveNextLogin(false);
    return;
  }

  void validateSignUpForm() {
    var validName = ValidationUtils.validateFullName(
      firstNameInputController.text,
    );
    var validEmail = ValidationUtils.validateEmail(emailSignUpController.text);
    var validUserType = selectedUserType.value.isNotEmpty;
    var validGender = selectedGender.value.isNotEmpty;
    var validDate = dateController.text.isNotEmpty;

    if (!validName) {
      updateWarningFirstName(true);
    } else if (validName) {
      updateWarningFirstName(false);
    }

    if (!validEmail) {
      updateWarningEmail(true);
    } else if (validEmail) {
      updateWarningEmail(false);
    }

    if (validGender && validDate && validEmail && validName && validUserType) {
      updateActiveNextfull(true);
      return;
    }

    updateActiveNextfull(false);
    return;
  }

  void onChangeSignUpPassword() {
    var validPassword = ValidationUtils.validatePassword(
      passwordSignUpController.text,
    );
    var validConfirmPassword = ValidationUtils.validatePassword(
      confirmPasswordSignUpController.text,
    );
    var paswordMatch =
        passwordSignUpController.text == confirmPasswordSignUpController.text;

    if (!validPassword) {
      updateSignUpWarningPassword(true);
    } else if (validPassword) {
      updateSignUpWarningPassword(false);
    }

    if (!validConfirmPassword) {
      updateSignUpWarningConfirmPassword(true);
    } else if (!paswordMatch) {
      updateSignUpWarningConfirmPassword(true);
    } else if (validConfirmPassword) {
      updateSignUpWarningConfirmPassword(false);
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

  void setSelectedGender(String gender) {
    selectedGender.value = gender;
    update();
  }

  void setSelectedUserType(String gender) {
    selectedUserType.value = gender;
    update();
  }

  void updateState(GetStartedLoginSignUpState value) {
    state.value = value;
    update();
  }

  void updateActiveNextfull(bool value) {
    activeNextfull.value = value;
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

  void updateWarningFirstName(bool value) {
    firstNameWarning.value = value;
    update();
  }

  void updateWarningEmail(bool value) {
    emailWarning.value = value;
    update();
  }

  void updateSignUpWarningPassword(bool value) {
    signUpPasswordWarning.value = value;
    update();
  }

  void updateSignUpWarningConfirmPassword(bool value) {
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

  Future<void> onSignUp() async {
    updateActiveNextPassword(false);

    var canSignUp = await _authProvider.canSignUp(
      email: emailSignUpController.text,
    );

    if (canSignUp) {
      var isRegister = await _authProvider.updateUser(
        email: emailSignUpController.text,
        password: passwordSignUpController.text,
      );

      if (isRegister != null) {
        var isUpdated = await _usuarioProvider.updateValidatedHasPassword(
          email: emailSignUpController.text,
          userUId: isRegister,
          value: true,
        );

        if (isUpdated) {
          var user = await _usuarioProvider.getUserByEmail(
            email: emailSignUpController.text,
          );

          if (user != null) {
            _preferences.setUserId = user.id ?? 0;
            _preferences.setEmail = user.email;
            _preferences.setFirstName = user.firstName;
            _preferences.setLastName = user.lastName ?? '';
            _preferences.setUserType = user.userType ?? '';
            _preferences.setGender = user.gender ?? '';
            _preferences.setImage = user.imageUrl ?? '';
            _preferences.setBirthDate = user.birthDate.toString();
            _preferences.setPhoneNumber = user.phoneNumber ?? 0;
            _preferences.setDocumentId = user.documentId ?? 0;
          }

          updateActiveNextPassword(false);
          if (_preferences.getUserType() == 'admin') {
            onAdminHome();
          } else if (_preferences.getUserType() == 'Propietario') {
            onFieldOwnerHome();
          } else {
            onUserHome();
          }

          return;
        }
      }
    }

    updateActiveNextPassword(true);
    AlertUtils.showMessageAlert(
      title: 'an_error_ocurred'.tr,
      buttonTitle: 'close'.tr,
      onPressed: () => Get.back(),
    );
    return;
  }

  Future<void> onCheckEmail() async {
    try {
      updateActiveNextfull(false);

      var canSignUp = await _authProvider.canSignUp(
        email: emailSignUpController.text,
      );

      if (!canSignUp) {
        updateActiveNextfull(true);
        AlertUtils.showMessageAlert(
          title: 'email_taken'.tr,
          buttonTitle: 'close'.tr,
          onPressed: () => Get.back(),
        );
        return;
      }

      var date = DateParseUtils.parseDate(dateController.text);

      if (date != null) {
        List<String> names = firstNameInputController.text.split(' ');

        if (names.isNotEmpty) {
          String firstName = names[0];
          String lastName = names[1];

          await _usuarioProvider.registerDbUser(
            usuario: User(
              email: emailSignUpController.text,
              gender: selectedGender.value,
              userType: selectedUserType.value,
              phoneType: getPhoneType(),
              firstName: firstName,
              lastName: lastName,
              birthDate: date,
            ),
          );

          _authProvider.requestOtp(email: emailSignUpController.text);

          updateState(GetStartedLoginSignUpState.validateOtp);
          updateReSendOtpTime(getOtpTime());
          updateActiveNextfull(true);
          updateRequestOtp(false);
          return;
        }
      }
    } catch (exception, stackTrace) {
      LogError.capture(exception, stackTrace, 'onCheckEmail');
    }
  }

  Future<void> onValidateOtp() async {
    if (emailSignUpController.text.isNotEmpty &&
        otpInputController.text.length == 6) {
      updateInvalidCodeMessage(false);

      var isValidated = await _authProvider.validateOtp(
        email: emailSignUpController.text,
        code: otpInputController.text,
      );

      if (isValidated) {
        var isUpdated = await _usuarioProvider.updateValidatedEmail(
          email: emailSignUpController.text,
          value: true,
        );

        if (isUpdated) {
          updateState(GetStartedLoginSignUpState.createPassword);
          resetOtpValues();
          return;
        }
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
    await _authProvider.requestOtp(email: emailSignUpController.text);
  }

  int getOtpTime() {
    int otpTime = DateTime.now().millisecondsSinceEpoch + 1000 * 60;
    return otpTime;
  }

  void doSignUpGoogle() {
    //TODO: required sign in with google
  }

  void doSignUpApple() {
    //TODO: required sign in with apple
  }

  void doSignUpFacebook() {
    //TODO: required sign in with facebook
  }

  void resetPasssword() {
    _authFlow.resetPassword();
  }

  void updateActiveNextLogin(bool value) {
    activeNextLogin.value = value;
    update();
  }

  void togglePasswordVisibility() {
    showPasswordLogin.value = !showPasswordLogin.value;
    update();
  }

  Future<void> onSignIn() async {
    updateActiveNextLogin(false);
    var validEmail = ValidationUtils.validateEmail(emailLoginController.text);
    var validPassword = ValidationUtils.validatePassword(
      passwordLoginController.text,
    );

    if (validEmail && validPassword) {
      var canLogin = await _authProvider.canlogin(
        email: emailLoginController.text,
      );

      if (canLogin) {
        var isSignIn = await _authProvider.signIn(
          email: emailLoginController.text,
          password: passwordLoginController.text,
        );

        if (isSignIn?.user != null) {
          var user = await _usuarioProvider.getUserByEmail(
            email: emailLoginController.text,
          );

          if (user != null) {
            _preferences.setUserId = user.id ?? 0;
            _preferences.setEmail = user.email;
            _preferences.setFirstName = user.firstName;
            _preferences.setLastName = user.lastName ?? '';
            _preferences.setUserType = user.userType ?? '';
            _preferences.setGender = user.gender ?? '';
            _preferences.setImage = user.imageUrl ?? '';
            _preferences.setBirthDate = user.birthDate.toString();
            _preferences.setPhoneNumber = user.phoneNumber ?? 0;
            _preferences.setDocumentId = user.documentId ?? 0;
          }

          if (_preferences.getUserType() == 'admin') {
            onAdminHome();
          } else if (_preferences.getUserType() == 'Propietario') {
            onFieldOwnerHome();
          } else {
            onUserHome();
          }
          return;
        }

        updateActiveNextLogin(false);
        AlertUtils.showMessageAlert(
          title: 'incorrect_email_or_password'.tr,
          buttonTitle: 'close'.tr,
          onPressed: () => Get.back(),
        );
        return;
      }

      updateActiveNextLogin(false);
      AlertUtils.showMessageAlert(
        title: 'user_does_not_exist'.tr,
        buttonTitle: 'close'.tr,
        onPressed: () => Get.back(),
      );
      return;
    }

    updateActiveNextLogin(true);
    AlertUtils.showMessageAlert(
      title: 'pattern'.tr,
      buttonTitle: 'close'.tr,
      onPressed: () => Get.back(),
    );
    return;
  }

  void chooseDate() async {
    var pickedDate = await showDatePicker(
      context: Get.context!,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
      helpText: 'Select DOB',
      cancelText: 'Close',
      confirmText: 'Confirm',
      errorFormatText: 'Enter valid date',
      errorInvalidText: 'Enter valid date range',
      fieldLabelText: 'DOB',
      fieldHintText: 'Month/Date/Year',
      selectableDayPredicate: disableDate,
    );

    if (pickedDate != null) {
      var validAge = DateParseUtils.isOfLegalAge(pickedDate);

      if (!validAge) {
        Get.snackbar('warning'.tr, 'insert_valid_date'.tr);
        FocusManager.instance.primaryFocus?.unfocus();
        dateController.clear();
        return;
      }

      var date = DateParseUtils.decodeDate(pickedDate.toString());
      dateController.text = date.toString();
      update();
      return;
    }
  }

  bool disableDate(DateTime day) {
    if ((day.isBefore(DateTime.now().add(const Duration(days: 0))))) {
      return true;
    }
    return false;
  }

  double determineHeight() {
    if (state.value == GetStartedLoginSignUpState.getStarted) {
      return AppSize.height() * 0.21;
    } else if (state.value == GetStartedLoginSignUpState.registerEmail) {
      return AppSize.height() * 0.75;
    } else if (state.value == GetStartedLoginSignUpState.validateOtp) {
      return AppSize.height() * 0.44;
    } else if (state.value == GetStartedLoginSignUpState.createPassword) {
      return AppSize.height() * 0.56;
    } else if (state.value == GetStartedLoginSignUpState.login) {
      return AppSize.height() * 0.52;
    }

    return AppSize.height() * 0;
  }
}
