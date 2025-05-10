import 'package:bukeet/widgets/images/asset_image_widget.dart';
import 'package:bukeet/widgets/text/text_widget.dart';
import 'package:flutter/material.dart';

class TextImageButtonWidget extends StatelessWidget {
  final String image;
  final String title;
  final double size;
  final Color titleColor;
  final VoidCallback onPressed;
  final String fontFamily;

  const TextImageButtonWidget({
    super.key,
    required this.image,
    required this.size,
    required this.title,
    required this.titleColor,
    required this.onPressed,
    required this.fontFamily,
  });

  @override
  Widget build(BuildContext context) {
    return _widgetContent();
  }

  Widget _widgetContent() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            elevation: 0.0,
            padding: const EdgeInsets.all(0.0),
            backgroundColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
          ),
          onPressed: () => onPressed(),
          child: AssetImageWidget(
            pathImage: image,
            width: size,
            height: size,
            fit: BoxFit.contain,
          ),
        ),
        TextWidget(
          title,
          fontFamily: fontFamily,
          color: titleColor,
          fontWeight: TextWidgetWeight.medium,
          dsize: RelSize(size: TextWidgetSizes.xsmall),
        ),
      ],
    );
  }
}
