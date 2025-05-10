import 'package:bukeet/preferences/user_preferences.dart';
import 'package:bukeet/settings/app_settings.dart';
import 'package:bukeet/utils/supabase/supabase_connection.dart';
import 'package:flutter/material.dart';

class AppDependencies {
  static Future<void> startAppDependencies() async {
    WidgetsFlutterBinding.ensureInitialized();
    AppSetting().startEnv();
    //await startFirebase();
    await UserPreferences().initPrefs();
    await SupabaseConnection().startConexion();

  }

 

}
