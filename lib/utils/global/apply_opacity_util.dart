import 'package:flutter/material.dart';

Color applyOpacity(Color color, double opacity) {
  return color.withValues(
    red: color.r,
    green: color.g,
    blue: color.b,
    alpha: opacity,
  );
}
