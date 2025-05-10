import 'package:bukeet/preferences/user_preferences.dart';
import 'package:bukeet/utils/global/log_error_utils.dart';
import 'package:permission_handler/permission_handler.dart';

Future<bool> hasPhotosPermission() async {
  try {
    var preferences = UserPreferences();
    var isRequestPermission = preferences.getPhotos();
    PermissionStatus permission = await Permission.photos.status;

    if (permission == PermissionStatus.granted && isRequestPermission) {
      return isRequestPermission;
    }
  } catch (exception, stackTrace) {
    LogError.capture(exception, stackTrace, 'hasPhotosPermission');
  }

  return false;
}

Future<bool> openSettingsPhotos() async {
  var preferences = UserPreferences();
  var isRequestPermission = preferences.getPhotos();
  PermissionStatus permission = await Permission.photos.status;

  if (isRequestPermission && permission == PermissionStatus.denied ||
      permission == PermissionStatus.permanentlyDenied) {
    return await openAppSettings();
  }

  return false;
}

Future<bool> hasDeniedPhotosPermission() async {
  var preferences = UserPreferences();
  var isRequestPermission = preferences.getPhotos();
  PermissionStatus permission = await Permission.photos.status;

  if (isRequestPermission && permission == PermissionStatus.denied ||
      permission == PermissionStatus.permanentlyDenied) {
    return true;
  }

  return false;
}
