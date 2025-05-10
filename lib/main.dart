import 'package:bukeet/binding/controllers.dart';
import 'package:bukeet/flows/authentication/routes/authentication_routes.dart';
import 'package:bukeet/i18n/translations_dictionary.dart';
import 'package:bukeet/routes/routes.dart';
import 'package:bukeet/system/orientation.dart';
import 'package:bukeet/system/system_style.dart';
import 'package:bukeet/utils/app/app_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

void main() async {
  await AppDependencies.startAppDependencies();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(systemStyle);
    SystemChrome.setPreferredOrientations(orientation);

    return GetMaterialApp(
      title: 'Bukeet',
      navigatorKey: navigatorKey,
      initialBinding: InitialBinding(),
      debugShowCheckedModeBanner: false,
      useInheritedMediaQuery: true,
      locale: Get.deviceLocale,
      translations: TranslationDictionary(),
      fallbackLocale: const Locale('en', 'US'),
      initialRoute: AuthenticationRoutes().validateAuth,
      getPages: Routes().getRoutes(),
      unknownRoute: Routes().getNotFoundPage(),
      theme: ThemeData(visualDensity: VisualDensity.adaptivePlatformDensity),
    );
  }
}
