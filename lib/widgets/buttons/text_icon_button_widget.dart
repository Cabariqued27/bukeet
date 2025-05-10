import 'package:bukeet/widgets/svg/svg_asset_widget.dart';
import 'package:bukeet/widgets/text/text_widget.dart';
import 'package:flutter/material.dart';

class TextIconButtonWidget extends StatelessWidget {
  final String icon;
  final String title;
  final double size;
  final Color iconColor;
  final Color buttonColor;
  final Color textColor;
  final VoidCallback onPressed;
  final String fontFamily;

  const TextIconButtonWidget({
    super.key,
    required this.size,
    required this.icon,
    required this.title,
    required this.iconColor,
    required this.buttonColor,
    required this.textColor,
    required this.onPressed,
    required this.fontFamily,
  });

  @override
  Widget build(BuildContext context) {
    return _widgetContent();
  }

  Widget _widgetContent() {
    return Column(
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            elevation: 0.0,
            padding: const EdgeInsets.all(0.0),
            backgroundColor: buttonColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
          ),
          onPressed: () => onPressed(),
          child: Container(
            width: size,
            height: size,
            padding: EdgeInsets.all(size * 0.16),
            child: SvgAssetWidget(
              path: icon,
              width: size,
              height: size,
              fit: BoxFit.contain,
            ),
          ),
        ),
        TextWidget(
          title,
          fontFamily: fontFamily,
          color: textColor,
          fontWeight: TextWidgetWeight.medium,
          dsize: RelSize(size: TextWidgetSizes.xsmall),
        ),
      ],
    );
  }
}
