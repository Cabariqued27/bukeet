import 'package:bukeet/widgets/svg/svg_asset_widget.dart';
import 'package:flutter/material.dart';

class IconGradientButtonWidget extends StatelessWidget {
  final bool isActive;
  final Color disableColor;
  final VoidCallback onPressed;
  final LinearGradient gradient;
  final double height;
  final double width;
  final FontWeight? fontWeight;
  final double? textSize;
  final String? icon;
  final String? iconRigth;
  final Color? iconColor;
  final double? iconSize;
  final String fontFamily;

  const IconGradientButtonWidget({
    super.key,
    required this.isActive,
    required this.onPressed,
    required this.gradient,
    required this.disableColor,
    required this.fontFamily,
    this.height = 0.0,
    this.width = 0.0,
    this.fontWeight,
    this.textSize,
    this.icon,
    this.iconRigth,
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
        color: disableColor,
        borderRadius: BorderRadius.circular(30.0),
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
        onPressed: (isActive) ? () => onPressed() : null,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [ _iconWidgetRigth()],
        ),
      ),
    );
  }



  Widget _iconWidgetRigth() {
    return (iconRigth != null && iconSize != null)
        ? SvgAssetWidget(
          path: iconRigth ?? '',
          width: iconSize,
          height: iconSize,
          color: iconColor,
          alignment: Alignment.center,
        )
        : const SizedBox();
  }
}
