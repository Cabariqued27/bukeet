import 'package:bukeet/utils/global/apply_opacity_util.dart';
import 'package:bukeet/widgets/svg/svg_asset_widget.dart';
import 'package:bukeet/widgets/text/text_widget.dart';
import 'package:flutter/material.dart';

class FinalGradientToggleColorButtonWidget extends StatelessWidget {
  final String title;
  final Color enableTextColor;
  final Color disableTextColor;
  final LinearGradient gradient;
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

  const FinalGradientToggleColorButtonWidget({
    super.key,
    required this.title,
    required this.onPressed,
    required this.enableTextColor,
    required this.disableTextColor,
    required this.disableColor,
    required this.gradient,
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
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
      gradient: (index == globalIndex)
          ? gradient
          : LinearGradient(
              colors: [
                disableColor,
                disableColor,
              ],
            ),
      borderRadius: BorderRadius.circular(30.0),
      boxShadow: (index == globalIndex)
          ? [
              BoxShadow(
                  color:applyOpacity(Colors.grey, 0.4),
                  spreadRadius: 0.2,
                  blurRadius: 5,
                ),
            ]
          : [], 
    ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
        elevation: 0.0,
        padding: const EdgeInsets.all(0.0),
        backgroundColor: Colors.transparent,
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
