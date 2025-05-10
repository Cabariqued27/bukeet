import 'package:bukeet/utils/app/app_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LeftArrowCongratulationSvgWidget extends StatelessWidget {
  final Color startColor;

  const LeftArrowCongratulationSvgWidget({
    super.key,
    required this.startColor,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: _loadSvgWithColors(context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return const Icon(Icons.error);
        } else {
          return SvgPicture.string(
            snapshot.data!,
            width: AppSize.width() * 0.1,
            height: AppSize.width() * 0.2,
          );
        }
      },
    );
  }

  Future<String> _loadSvgWithColors(BuildContext context) async {
    // Load the SVG from assets
    String svgString = await DefaultAssetBundle.of(context).loadString('assets/icons/left_arrow_congratulation_icon.svg');

    // Replace placeholder colors with actual colors
    svgString = svgString.replaceAll('START_COLOR', _colorToHex(startColor));
   

    return svgString;
  }

  String _colorToHex(Color color) {
    return '#${color.value.toRadixString(16).substring(2).toUpperCase()}';
  }
}
