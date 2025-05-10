import 'package:flutter/material.dart';

class AssetImageWidget extends StatelessWidget {
  final double width;
  final double height;
  final String pathImage;
  final BoxFit fit;

  const AssetImageWidget({
    Key? key,
    this.width = 0.0,
    this.height = 0.0,
    this.fit = BoxFit.cover,
    required this.pathImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _widgetContent();
  }

  Widget _widgetContent() {
    return Image(
      width: width,
      height: height,
      image: AssetImage(pathImage),
      fit: fit,
    );
  }
}
