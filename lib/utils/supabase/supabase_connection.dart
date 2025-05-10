import 'package:bukeet/settings/app_settings.dart';
import 'package:bukeet/utils/global/log_error_utils.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseConnection {
  Future<bool> startConexion() async {
    try {
      await Supabase.initialize(
        url: AppSetting.servicesSettings.supabaseUrl,
        anonKey: AppSetting.servicesSettings.supabaseAnonKey,
      );

      return true;
    } catch (exception, stackTrace) {
      LogError.capture(exception, stackTrace, 'startConexion');
      return false;
    }
  }
}
