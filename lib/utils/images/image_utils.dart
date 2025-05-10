import 'dart:io';
import 'package:bukeet/utils/global/log_error_utils.dart';
import 'package:image_picker/image_picker.dart';

class ImageUtils {
  static File? xFileToFile(XFile data) {
    try {
      return File(data.path);
    } catch (exception, stackTrace) {
      LogError.capture(exception, stackTrace, 'xFileToFile');
      return null;
    }
  }
}
