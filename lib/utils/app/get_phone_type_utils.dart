import 'package:bukeet/services/enums/device_type_enum.dart';
import 'package:flutter/foundation.dart';

String getPhoneType() {
  if (kIsWeb) {
    return PhoneTypeEnum.web;
  } else if (defaultTargetPlatform == TargetPlatform.iOS) {
    return PhoneTypeEnum.ios;
  } else if (defaultTargetPlatform == TargetPlatform.android) {
    return PhoneTypeEnum.android;
  }

  return PhoneTypeEnum.none;
}
