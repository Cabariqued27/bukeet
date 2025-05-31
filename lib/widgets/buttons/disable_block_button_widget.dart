import 'package:bukeet/utils/app/app_size.dart';
import 'package:bukeet/utils/global/apply_opacity_util.dart';
import 'package:bukeet/widgets/svg/svg_asset_widget.dart';
import 'package:flutter/material.dart';

class DisableBlockButtonWidget extends StatelessWidget {
  final bool isActive;
  final String backIcon;
  final String frontIcon;
  final Color lineColor;
  final VoidCallback? onPressed;

  const DisableBlockButtonWidget({
    super.key,
    required this.isActive,
    required this.backIcon,
    required this.frontIcon,
    required this.onPressed,
    required this.lineColor,
  });

  @override
  Widget build(BuildContext context) {
    return _widgetContent();
  }

  Widget _widgetContent() {
    var size = AppSize.width() * 0.12;

    return SizedBox(
      width: size + (size * 0.25),
      height: size,
      child: InkWell(
        onTap: (onPressed != null) ? () => onPressed!() : null,
        child: (isActive)
            ? SvgAssetWidget(
                path: backIcon,
                width: size,
                height: size,
                alignment: Alignment.center,
              )
            : Stack(
                children: [
                  Positioned.fill(
                    child: Align(
                      alignment: Alignment.center,
                      child: SvgAssetWidget(
                        path: backIcon,
                        width: size,
                        height: size,
                        alignment: Alignment.center,
                        color: applyOpacity(
                          const Color.fromARGB(255, 255, 255, 255),
                          0.2,
                        ),
                      ),
                    ),
                  ),
                  Positioned.fill(
                    child: Align(
                      alignment: Alignment.center,
                      child: SvgAssetWidget(
                        path: frontIcon,
                        width: size,
                        height: size,
                        alignment: Alignment.center,
                        color: lineColor,
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
