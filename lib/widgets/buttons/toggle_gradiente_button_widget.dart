import 'package:bukeet/utils/global/apply_opacity_util.dart';
import 'package:bukeet/widgets/svg/svg_asset_widget.dart';
import 'package:bukeet/widgets/text/text_widget.dart';
import 'package:flutter/material.dart';

class ToggleGradientButtonWidget extends StatelessWidget {
  final String title;
  final bool colorStatus;
  final bool isActivate;
  final Color textColor;
  final Color disableColor;
  final VoidCallback onPressed;
  final LinearGradient gradient;
  final double height;
  final double width;
  final FontWeight? fontWeight;
  final double? textSize;
  final String fontFamily;

  final String? icon;
  final Color? iconColor;
  final double? iconSize;

  const ToggleGradientButtonWidget({
    super.key,
    required this.title,
    required this.colorStatus,
    required this.isActivate,
    required this.onPressed,
    required this.textColor,
    required this.gradient,
    required this.disableColor,
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
    margin: const EdgeInsets.all(0.0),
    padding: const EdgeInsets.all(0.0),
    decoration: BoxDecoration(
      gradient: (colorStatus)
          ? gradient
          : LinearGradient(
              colors: [
                disableColor,
                disableColor,
              ],
            ),
      borderRadius: BorderRadius.circular(30.0),
      boxShadow: colorStatus
          ? [
              BoxShadow(
                  color:applyOpacity(Colors.grey, 0.4),
                  spreadRadius: 0.2,
                  blurRadius: 5,
                ),
            ]
          : [], // No sombra si el botón no está activo
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
      onPressed: isActivate ? () => onPressed() : null,
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
            color: textColor,
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
