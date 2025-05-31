import 'package:bukeet/utils/global/apply_opacity_util.dart';
import 'package:bukeet/utils/global/log_error_utils.dart';
import 'package:flutter/material.dart';

Color stringToColor(String value) {
  try {
    if (value.isEmpty) {
      return Colors.white;
    }

    var color = Color(int.parse('0xff$value'));
    return color;
  } catch (exception, stackTrace) {
    LogError.capture(exception, stackTrace, 'stringToColor');
    return Colors.white;
  }
}

LinearGradient listStringToGradient(List<dynamic>? data) {
  try {
    if (data != null && data.isNotEmpty) {
      var gradientColors = <Color>[];

      for (String item in data) {
        var color = Color(int.parse('0xff$item'));
        gradientColors.add(color);
      }

      var gradient = LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: gradientColors,
      );

      return gradient;
    }
  } catch (exception, stackTrace) {
    LogError.capture(exception, stackTrace, 'listStringToGradient');
  }

  return LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [
      applyOpacity(Colors.black, 1.0),
      applyOpacity(Colors.black, 0.6),
      applyOpacity(Colors.black, 0.3),
    ],
  );
}

LinearGradient listStringToGradientExplore(List<dynamic>? data) {
  try {
    if (data != null && data.isNotEmpty) {
      var gradientColors = <Color>[];

      for (String item in data) {
        var color = Color(int.parse('0xff$item'));
        gradientColors.add(color);
      }

      var gradient = LinearGradient(
        stops: const [0.2, 0.8],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: gradientColors,
      );

      return gradient;
    }
  } catch (exception, stackTrace) {
    LogError.capture(exception, stackTrace, 'listStringToGradient');
  }

  return LinearGradient(
    stops: const [0.2, 0.8],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      applyOpacity(Colors.black, 1.0),
      applyOpacity(Colors.black, 0.6),
      applyOpacity(Colors.black, 0.3),
    ],
  );
}
