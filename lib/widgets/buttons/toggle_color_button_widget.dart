import 'package:bukeet/widgets/svg/svg_asset_widget.dart';
import 'package:bukeet/widgets/text/text_widget.dart';
import 'package:flutter/material.dart';

class ToggleColorButtonWidget extends StatelessWidget {
  final String title;
  final Color enableTextColor;
  final Color disableTextColor;
  final Color enableColor;
  final Color disableColor;
  final Function(int) onPressed;
  final double height;
  final double width;
  final FontWeight? fontWeight;
  final double? textSize;
  final String? icon;
  final Color? iconColor;
  final double? iconSize;
  final int globalIndex;
  final int index;
  final String fontFamily;

  const ToggleColorButtonWidget({
    super.key,
    required this.title,
    required this.onPressed,
    required this.enableTextColor,
    required this.disableTextColor,
    required this.disableColor,
    required this.enableColor,
    required this.globalIndex,
    required this.index,
    required this.fontFamily,
    this.height = 0.0,
    this.width = 0.0,
    this.fontWeight,
    this.textSize,
    this.icon,
    this.iconColor,
    this.iconSize,
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
          padding: const EdgeInsets.all(0.0),
          backgroundColor: (index == globalIndex) ? enableColor : disableColor,
          foregroundColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
        ),
        onPressed: () => onPressed(index),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _iconWidget(),
            TextWidget(
              title,
              fontFamily: fontFamily,
              textAlign: TextAlign.center,
              dsize: RelSize(
                size: textSize ?? TextWidgetSizes.small,
              ),
              color:
                  (index == globalIndex) ? enableTextColor : disableTextColor,
              fontWeight: fontWeight ?? TextWidgetWeight.medium,
            ),
          ],
        ),
      ),
    );
  }

  Widget _iconWidget() {
    return (icon != null && iconSize != null)
        ? Container(
            margin: const EdgeInsets.only(right: 10.0),
            child: SvgAssetWidget(
              path: icon ?? '',
              width: iconSize,
              height: iconSize,
              color: iconColor,
              alignment: Alignment.center,
            ),
          )
        : const SizedBox();
  }
}
