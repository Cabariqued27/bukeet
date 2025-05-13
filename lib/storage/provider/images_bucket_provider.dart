import 'dart:io';
import 'package:bukeet/preferences/user_preferences.dart';
import 'package:bukeet/storage/buckets/buckets.dart';
import 'package:bukeet/utils/global/log_error_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ImagesBucketProvider {
  final _supabase = Supabase.instance.client;
  final _preferences = UserPreferences();

  Future<String?> setFieldsImage(File file) async {
    try {
      var userId = _preferences.getUserId();
      var time = DateTime.now().microsecond;

      var nameImage = 'fieldsImages-$userId-$time.png';

      var publicUrl = getPublicUrl(nameImage, Buckets.fieldImages);

      if (!kIsWeb) {
        await _supabase.storage
            .from(Buckets.fieldImages)
            .upload(nameImage, file);
        return publicUrl;
      }

      await _supabase.storage
          .from(Buckets.fieldImages)
          .uploadBinary(nameImage, file.readAsBytesSync());

      return publicUrl;
    } catch (exception, stackTrace) {
      LogError.capture(exception, stackTrace, 'setFieldsImage');
      return null;
    }
  }

  Future<String?> setArenasImage(File file) async {
    try {
      var userId = _preferences.getUserId();
      var time = DateTime.now().microsecond;

      var nameImage = 'arenasImages-$userId-$time.png';

      var publicUrl = getPublicUrl(nameImage, Buckets.arenaImages);

      if (!kIsWeb) {
        await _supabase.storage
            .from(Buckets.arenaImages)
            .upload(nameImage, file);
        return publicUrl;
      }

      await _supabase.storage
          .from(Buckets.arenaImages)
          .uploadBinary(nameImage, file.readAsBytesSync());

      return publicUrl;
    } catch (exception, stackTrace) {
      LogError.capture(exception, stackTrace, 'setArenasImage');
      return null;
    }
  }

  Future<String?> setSupportImage(File file) async {
    try {
      var userId = _preferences.getUserId();
      var time = DateTime.now().microsecond;

      var nameImage = 'support-$userId-$time.png';

      var publicUrl = getPublicUrl(nameImage, Buckets.supportImages);

      if (!kIsWeb) {
        await _supabase.storage
            .from(Buckets.supportImages)
            .upload(nameImage, file);
        return publicUrl;
      }

      await _supabase.storage
          .from(Buckets.supportImages)
          .uploadBinary(nameImage, file.readAsBytesSync());

      return publicUrl;
    } catch (exception, stackTrace) {
      LogError.capture(exception, stackTrace, 'setSupportImage');
      return null;
    }
  }

  String? getPublicUrl(String name, String bucket) {
    try {
      if (name.isNotEmpty) {
        final String url = _supabase.storage.from(bucket).getPublicUrl(name);

        if (url.contains('png')) {
          return url;
        }
      }
    } catch (exception, stackTrace) {
      LogError.capture(exception, stackTrace, 'getPublicUrl');
    }

    return null;
  }
}
