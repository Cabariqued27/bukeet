import 'package:bukeet/utils/regex/regex_utils.dart';


class ValidationUtils {
  static bool validateEmail(String value) {
    if (value.isEmpty) {
      return false;
    }

    final RegExp emailRegExp = RegExp(RegexPattern.emailRegex);

    if (!emailRegExp.hasMatch(value)) {
      return false;
    }

    return true;
  }

  static bool validatePassword(String value) {
    RegExp regex = RegExp(RegexPattern.passwordRegex);

    if (value.isEmpty) {
      return false;
    }

    if (!regex.hasMatch(value)) {
      return false;
    }

    return true;
  }

  static bool validateName(String value) {
    RegExp regex = RegExp(RegexPattern.nameRegex);

    if (value.isEmpty) {
      return false;
    }

    if (!regex.hasMatch(value)) {
      return false;
    }

    return true;
  }

  static bool validateFullName(String value) {
    RegExp regex = RegExp(RegexPattern.fullNameRegex);

    if (value.isEmpty) {
      return false;
    }

    if (!regex.hasMatch(value)) {
      return false;
    }

    return true;
  }
}
