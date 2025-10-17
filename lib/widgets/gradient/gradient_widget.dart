import 'package:bukeet/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GradientWidget extends StatelessWidget {
  final Widget child;
  final LinearGradient? gradient;

  GradientWidget({super.key, required this.child, this.gradient});

  final _theme = Get.find<AppTheme>();

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) =>
          gradient?.createShader(
            Rect.fromLTWH(0, 0, bounds.width, bounds.height),
          ) ??
          _theme.refreshBackgroundExplore.value.createShader(
            Rect.fromLTWH(0, 0, bounds.width, bounds.height),
          ),
      child: child,
    );
  }
}
