import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SvgIconNetworkWidget extends StatelessWidget {
  final double? width;
  final double? height;
  final String path;
  final double margin;
  final Color? color;
  final bool calculateColor;
  final AlignmentGeometry alignment;
  final BoxFit fit;

  const SvgIconNetworkWidget({
    super.key,
    this.width = 0.0,
    this.height = 0.0,
    this.margin = 0.0,
    required this.path,
    this.color,
    this.calculateColor = false,
    this.alignment = Alignment.center,
    this.fit = BoxFit.contain,
  });

  @override
  Widget build(BuildContext context) {
    if (path == 'NULL' || path == '') {
      return SizedBox(width: width, height: height);
    } else {
      return Container(
        margin: EdgeInsets.all(margin),
        child: SvgPicture.network(
          path,
          semanticsLabel: 'icon',
          fit: fit,
          width: width,
          height: height,
          // ignore: deprecated_member_use
          color: color,
          alignment: alignment,
        ),
      );
    }
  }
}
