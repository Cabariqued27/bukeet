import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class StreakSvgAssetWidget extends StatelessWidget {
  final double? width;
  final double? height;
  final String path;
  final Color? color1;
  final Color? color2;
  final double margin;
  final bool allowDrawingOutsideViewBox;
  final AlignmentGeometry alignment;
  final BoxFit fit;

  const StreakSvgAssetWidget({
    Key? key,
    this.width = 0.0,
    this.height = 0.0,
    this.margin = 0.0,
    this.color1,
    this.color2,
    this.allowDrawingOutsideViewBox = false,
    this.alignment = Alignment.center,
    this.fit = BoxFit.contain,
    required this.path,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: _loadSvgWithColors(context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
          return Container(
            width: width,
            height: height,
            margin: EdgeInsets.all(margin),
            child: SvgPicture.string(
              snapshot.data!,
              fit: fit,
              alignment: alignment,
              semanticsLabel: 'icon',
              allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
            ),
          );
        } else {
          return Container(
            width: width,
            height: height,
            margin: EdgeInsets.all(margin),
            child: const Center(child: CircularProgressIndicator()),
          );
        }
      },
    );
  }

   Future<String> _loadSvgWithColors(BuildContext context) async {
    String svgString = await DefaultAssetBundle.of(context).loadString(path);
    if (color1 != null) {
      svgString = svgString.replaceAll('{{COLOR1}}', _colorToHex(color1!));
    }
    if (color2 != null) {
      svgString = svgString.replaceAll('{{COLOR2}}', _colorToHex(color2!));
    }
    return svgString;
  }

  String _colorToHex(Color color) {
    return '#${color.value.toRadixString(16).padLeft(8, '0').substring(2)}';
  }
}
