import 'package:bukeet/env/dev.dart';
import 'package:bukeet/models/services_settings.dart';

class AppSetting {
  static late ServiceSetting servicesSettings;
  static const String appVersion = '1.2.1';
  static const int validLegalAge = 10;

  static const int minAverageWindow = 2;
  static const int maxAverageWindow = 30;

  void startEnv() {
    servicesSettings = startDev();
    return;
  }
}
