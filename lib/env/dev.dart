import 'package:bukeet/models/services_settings.dart';
import 'package:bukeet/secrets.dart';

ServiceSetting startDev() {
  return ServiceSetting(
      supabaseUrl: supabaseUrl, supabaseAnonKey: supabaseAnonKey,);
}
