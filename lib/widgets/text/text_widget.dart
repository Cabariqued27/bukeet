import 'dart:math';
import 'package:bukeet/theme/theme.dart';
import 'package:bukeet/widgets/text/app_fonts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TextWidget extends StatelessWidget {
  final String text;
  final Color? color;
  final FontWeight? fontWeight;
  final IDynamicSize? dsize;
  final TextDecoration decoration;
  final TextAlign textAlign;
  final TextOverflow textOverflow;
  final bool? calculateColor;
  final FontStyle fontStyle;
  final double? height;
  final int? maxLines;
  final TextDirection? textDirection;
  final String fontFamily;
  final double? letterSpacing;

  const TextWidget(
    this.text, {
    required this.fontFamily,
    this.color,
    this.dsize,
    this.calculateColor = false,
    this.textAlign = TextAlign.start,
    this.fontWeight = FontWeight.normal,
    this.decoration = TextDecoration.none,
    this.textOverflow = TextOverflow.ellipsis,
    this.fontStyle = FontStyle.normal,
    this.height,
    this.maxLines,
    this.textDirection,
    this.letterSpacing,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var textStyle = validateTextStyle(
      fontFamily: fontFamily,
      letterSpacing: letterSpacing,
      color: color ?? AppTheme().text.value,
      fontWeight: fontWeight,
      decoration: decoration,
      fontStyle: fontStyle,
      height: height,
      dsize: dsize,
    );

    return Text(
      text,
      style: textStyle,
      maxLines: maxLines,
      textAlign: textAlign,
      overflow: textOverflow,
      textDirection: textDirection,
    );
  }
}

class AppFontFamily {
  static const String workSans = 'WorkSans';
  static const String leagueSpartan = 'LeagueSpartan';
}

TextStyle validateTextStyle({
  required String fontFamily,
  Color? color,
  FontWeight? fontWeight,
  TextDecoration? decoration,
  FontStyle? fontStyle,
  double? height,
  IDynamicSize? dsize,
  double? letterSpacing,
}) {
  return CustomFonts.getCustomTextStyle(
    family: fontFamily,
    letterSpacing: letterSpacing,
    color: color ?? AppTheme().text.value,
    fontWeight: fontWeight,
    decoration: decoration,
    decorationColor: color ?? AppTheme().text.value,
    fontStyle: fontStyle,
    height: height,
    dsize: (dsize != null) ? dsize : RelSize(size: TextWidgetSizes.normal),
  );
}

class TextWidgetSizes {
  static double xxxxxsmall = 0.004;
  static double xxxxsmall = 0.008;
  static double xxxsmall = 0.012;
  static double xxsmall = 0.014;
  static double xsmall = 0.016;
  static double msmall = 0.018;
  static double xmsmall = 0.019;
  static double small = 0.020;
  static double buttonsTitle = 0.022;
  static double buttonsTitleX = 0.024;
  static double normal = 0.025;
  static double semiLarge = 0.027;
  static double large = 0.030;
  static double xlarge = 0.035;
  static double xmlarge = 0.037;
  static double xxlarge = 0.040;
  static double xxxlarge = 0.045;
  static double xxxxlarge = 0.055;
  static double xxxxxlarge = 0.065;
  static double xxxxxxlarge = 0.075;
  static double xxxxxxxlarge = 0.085;
  static double xxxxxxxxlarge = 0.095;
}

class TextWidgetWeight {
  static FontWeight extraLight = FontWeight.w100;
  static FontWeight light = FontWeight.w300;
  static FontWeight normal = FontWeight.w400;
  static FontWeight medium = FontWeight.w500;
  static FontWeight bold = FontWeight.w600;
  static FontWeight extraBold = FontWeight.w700;
  static FontWeight extraBoldUltra = FontWeight.w900;
}

class RelSize implements IDynamicSize {
  final double wRatio;
  final double hRatio;
  final double size;

  RelSize({
    this.wRatio = 0,
    this.hRatio = 1,
    this.size = 0.025,
  });

  @override
  double getSize() {
    double res = sqrt(
      pow(Get.width * wRatio, 2) + pow(Get.height * hRatio, 2),
    );

    return res * size;
  }
}

class AbsSize implements IDynamicSize {
  final double size;

  AbsSize(this.size);

  @override
  double getSize() {
    throw UnimplementedError();
  }
}

abstract class IDynamicSize {
  double getSize();
}

TextStyle onlyTextStyle({
  required String fontFamily,
  Color? color,
  FontWeight? fontWeight,
  IDynamicSize? dsize,
  TextDecoration? decoration,
  TextAlign? textAlign,
  TextOverflow? textOverflow,
  bool? calculateColor,
  FontStyle? fontStyle,
  double? height,
  double? letterSpacing,
}) {
  var textStyle = validateTextStyle(
    letterSpacing: letterSpacing,
    fontFamily: fontFamily,
    color: color ?? AppTheme().text.value,
    fontWeight: fontWeight,
    decoration: decoration,
    fontStyle: fontStyle,
    height: height,
    dsize: dsize,
  );

  return textStyle;
}
