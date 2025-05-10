import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

final systemStyle = SystemUiOverlayStyle.dark.copyWith(
    statusBarColor: Colors.transparent,
    statusBarBrightness: Brightness.light,
    statusBarIconBrightness: Brightness.dark,
    systemNavigationBarColor: const Color(0xff2A2D32),
    systemNavigationBarIconBrightness: Brightness.dark
);
