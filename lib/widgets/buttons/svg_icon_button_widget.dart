import 'package:bukeet/widgets/svg/svg_asset_widget.dart';
import 'package:flutter/material.dart';

class SvgIconButtonWidget extends StatelessWidget {
  final String icon;
  final double size;
  final Color? color;
  final VoidCallback? onPressed;
  final AlignmentGeometry alignment;

  const SvgIconButtonWidget({
    Key? key,
    required this.icon,
    required this.size,
    required this.onPressed,
    this.color,
    this.alignment = Alignment.center,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _widgetContent();
  }

  Widget _widgetContent() {
    return SizedBox(
      width: size + (size * 0.25),
      height: size,
      child: InkWell(
        onTap: (onPressed != null) ? () => onPressed!() : null,
        child: SvgAssetWidget(
          path: icon,
          width: size,
          height: size,
          color: color,
          alignment: alignment,
        ),
      ),
    );
  }
}
