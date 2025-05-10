import 'package:bukeet/widgets/svg/svg_asset_widget.dart';
import 'package:bukeet/widgets/text/text_widget.dart';
import 'package:flutter/material.dart';

class BorderButtonWidget extends StatelessWidget {
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
  final String? leftIcon;
  final String? rightIcon;
  final Color? iconColor;
  final String fontFamily;
  final double? iconSize;
  final double? border;

  const BorderButtonWidget({
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
    this.leftIcon,
    this.rightIcon,
    this.iconColor,
    this.iconSize,
    this.border,
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
                  borderRadius: BorderRadius.circular(border ?? 30.0),
                )
              : null,
        ),
        onPressed: (isActive) ? () => onPressed() : null,
        child: _buttonContent(),
      ),
    );
  }

  Widget _buttonContent() {
    if (leftIcon != null && rightIcon != null) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _iconWidget(rightIcon ?? ''),
          SizedBox(width: height * 0.2),
          _titleWidget(),
          SizedBox(width: height * 0.2),
          _iconWidget(leftIcon ?? ''),
        ],
      );
    }

    if (leftIcon != null) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _iconWidget(leftIcon ?? ''),
          SizedBox(width: height * 0.2),
          _titleWidget(),
        ],
      );
    }

    if (rightIcon != null) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _titleWidget(),
          SizedBox(width: height * 0.2),
          _iconWidget(rightIcon ?? ''),
        ],
      );
    }

    return _titleWidget();
  }

  Widget _titleWidget() {
    return TextWidget(
      title,
      fontFamily: fontFamily,
      textAlign: TextAlign.center,
      dsize: RelSize(
        size: textSize ?? TextWidgetSizes.normal,
      ),
      color: textColor,
      fontWeight: fontWeight ?? TextWidgetWeight.medium,
    );
  }

  Widget _iconWidget(String icon) {
    var size = height * 0.35;

    return SvgAssetWidget(
      width: iconSize ?? size,
      height: iconSize ?? size,
      path: icon,
      fit: BoxFit.contain,
      color: iconColor,
    );
  }
}
