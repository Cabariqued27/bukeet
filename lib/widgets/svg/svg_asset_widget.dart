import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SvgAssetWidget extends StatelessWidget {
  final double? width;
  final double? height;
  final String path;
  final Color? color;
  final double margin;
  final bool allowDrawingOutsideViewBox;
  final AlignmentGeometry alignment;
  final BoxFit fit;

  const SvgAssetWidget({
    Key? key,
    this.width = 0.0,
    this.height = 0.0,
    this.margin = 0.0,
    this.color,
    this.allowDrawingOutsideViewBox = false,
    this.alignment = Alignment.center,
    this.fit = BoxFit.contain,
    required this.path,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: EdgeInsets.all(margin),
      child: SvgPicture.asset(
        path,
        fit: fit,
        // ignore: deprecated_member_use
        color: color,
        width: width,
        height: height,
        alignment: alignment,
        semanticsLabel: 'icon',
        allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
      ),
    );
  }
}
