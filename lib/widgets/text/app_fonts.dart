import 'package:bukeet/widgets/text/text_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CustomFonts {
  static const String emojis = 'Emoji';
  static const String rubik = 'Rubik';
  static const String poppins = 'Poppins';
  static const String montserrat = 'Montserrat';
  static const String sourceSans = 'SourceSans';
  static const String avenirNextLTPro = 'AvenirNextLTPro';
  static const String roboto = 'Roboto';

  static TextStyle getCustomTextStyle({
    required String family,
    FontWeight? fontWeight,
    IDynamicSize? dsize,
    TextDecoration? decoration,
    FontStyle? fontStyle,
    double? height,
    Color? color,
    Color? decorationColor,
    double? letterSpacing,
  }) {
    var size = (dsize != null)
        ? dsize.getSize()
        : RelSize(size: TextWidgetSizes.normal).getSize();

    final fontFamilyFallback = <String>[];

    if (kIsWeb) {
      fontFamilyFallback.add(emojis);
    }

    return TextStyle(
      fontSize: size,
      color: color,
      fontWeight: fontWeight,
      decoration: decoration,
      fontStyle: fontStyle,
      height: height,
      fontFamily: family,
      fontFamilyFallback: fontFamilyFallback,
      decorationColor: decorationColor,
      letterSpacing: letterSpacing,
    );
  }
}
