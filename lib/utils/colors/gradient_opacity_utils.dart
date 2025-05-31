import 'package:bukeet/utils/global/apply_opacity_util.dart';
import 'package:bukeet/utils/global/log_error_utils.dart';
import 'package:flutter/material.dart';

LinearGradient copyGradientWithOpacity(
  LinearGradient original,
  double opacity,
) {
  try {
    var colors =
        original.colors.map((color) => applyOpacity(color, opacity)).toList();

    return LinearGradient(
      colors: colors,
      begin: original.begin,
      end: original.end,
      stops: original.stops,
      tileMode: original.tileMode,
    );
  } catch (exception, stackTrace) {
    LogError.capture(exception, stackTrace, 'addOpacityToGradient');
  }
  return original;
}
