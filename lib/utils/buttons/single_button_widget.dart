import 'package:bukeet/widgets/text/text_widget.dart';
import 'package:flutter/material.dart';

class SingleButtonWidget extends StatelessWidget {
  final String title;
  final bool isActive;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color textColor;
  final Color? borderColor;
  final double height;
  final double width;
  final FontWeight? fontWeight;
  final double? textSize;
  final String fontFamily;

  const SingleButtonWidget({
    super.key,
    required this.title,
    required this.isActive,
    required this.onPressed,
    required this.backgroundColor,
    required this.textColor,
    required this.fontFamily,
    this.borderColor,
    this.height = 0.0,
    this.width = 0.0,
    this.fontWeight,
    this.textSize,
  });

  @override
  Widget build(BuildContext context) {
    return _widgetContent();
  }

  Widget _widgetContent() {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 0.0,
          backgroundColor: backgroundColor,
          shape: (borderColor != null)
              ? RoundedRectangleBorder(
                  side: BorderSide(
                    color: borderColor!,
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(30.0),
                )
              : null,
        ),
        onPressed: (isActive) ? () => onPressed() : null,
        child: TextWidget(
          title,
          fontFamily: fontFamily,
          textAlign: TextAlign.center,
          dsize: RelSize(
            size: textSize ?? TextWidgetSizes.normal,
          ),
          color: textColor,
          fontWeight: fontWeight ?? TextWidgetWeight.medium,
        ),
      ),
    );
  }
}
