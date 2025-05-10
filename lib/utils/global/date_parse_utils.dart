import 'package:bukeet/settings/app_settings.dart';
import 'package:bukeet/utils/global/log_error_utils.dart';
import 'package:intl/intl.dart';


class DateParseUtils {
  static DateTime? parseDate(String value) {
    try {
      DateFormat format = DateFormat("dd-MM-yyyy");
      DateTime date = format.parse(value);

      return date;
    } catch (exception, stackTrace) {
      LogError.capture(exception, stackTrace, 'parseDate');
      return null;
    }
  }

  static String decodeDate(String value) {
    try {
      DateTime date = DateTime.parse(value);

      DateFormat dateFormat = DateFormat("dd-MM-yyyy");

      return dateFormat.format(date);
    } catch (exception, stackTrace) {
      LogError.capture(exception, stackTrace, 'decodeDate');
      return value;
    }
  }

  static bool isOfLegalAge(DateTime date) {
    try {
      DateTime currentDate = DateTime.now();
      var legalAge = AppSetting.validLegalAge;

      int differenceInYears = currentDate.year - date.year;

      if (differenceInYears > legalAge ||
          (differenceInYears == legalAge &&
              (currentDate.month > date.month ||
                  (currentDate.month == date.month &&
                      currentDate.day >= date.day)))) {
        return true;
      }
    } catch (exception, stackTrace) {
      LogError.capture(exception, stackTrace, 'isOfLegalAge');
    }

    return false;
  }

  static int? getSecondsAndMilliseconds(int value) {
    try {
      DateTime now = DateTime.now();
      var newDateTime = now.add(Duration(milliseconds: value));

      int seconds = newDateTime.second;
      int milliseconds = newDateTime.millisecond;

      String secondsString = seconds.toString().padLeft(2, '0');
      String millisecondsString = milliseconds.toString().padLeft(3, '0');
      var returnValue = int.parse('$secondsString$millisecondsString');

      return returnValue;
    } catch (exception, stackTrace) {
      LogError.capture(exception, stackTrace, 'getSecondsAndMilliseconds');
    }

    return null;
  }
}
