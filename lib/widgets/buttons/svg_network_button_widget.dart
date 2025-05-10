import 'package:bukeet/widgets/svg/svg_network_widget.dart';
import 'package:bukeet/widgets/text/text_widget.dart';
import 'package:flutter/material.dart';

class SvgNetworkButtonWidget extends StatelessWidget {
  final String urlIcon;
  final String title;
  final double size;
  final Color titleColor;
  final Color backgroundColor;
  final VoidCallback onPressed;
  final Color? iconColor;
  final bool isMoodSelected;
  final int selectedMoodId;
  final int id;
  final Color? activeButtonColor;
  final Color? activeIconColor;
  final String fontFamily;
  final bool showTitle;

  const SvgNetworkButtonWidget({
    super.key,
    required this.id,
    required this.urlIcon,
    required this.size,
    required this.title,
    required this.titleColor,
    required this.onPressed,
    required this.backgroundColor,
    required this.fontFamily,
    this.isMoodSelected = false,
    this.selectedMoodId = 0,
    this.iconColor,
    this.activeButtonColor,
    this.activeIconColor,
    this.showTitle = true,
  });

  @override
  Widget build(BuildContext context) {
    return _widgetContent();
  }

  Widget _widgetContent() {
    return (!isMoodSelected)
        ? _initialStateWidget()
        : (id != selectedMoodId)
            ? _noSelectedWidget()
            : _selectedWidget();
  }

  Widget _initialStateWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: size,
          height: size,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              elevation: 0.0,
              padding: const EdgeInsets.all(0.0),
              backgroundColor: backgroundColor,
              foregroundColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            onPressed: () => onPressed(),
            child: Container(
              margin: EdgeInsets.all(size * 0.2),
              child: SvgIconNetworkWidget(
                path: urlIcon,
                width: size,
                height: size,
                fit: BoxFit.contain,
                color: iconColor,
              ),
            ),
          ),
        ),
        (showTitle)
            ? TextWidget(
                title,
                fontFamily: fontFamily,
                color: titleColor,
                fontWeight: TextWidgetWeight.medium,
                dsize: RelSize(size: TextWidgetSizes.xsmall),
              )
            : const SizedBox(),
      ],
    );
  }

  Widget _noSelectedWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: size,
          height: size,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              elevation: 0.0,
              padding: const EdgeInsets.all(0.0),
              backgroundColor: Colors.transparent,
              foregroundColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
            onPressed: () => onPressed(),
            child: Container(
              margin: EdgeInsets.all(size * 0.2),
              child: SvgIconNetworkWidget(
                path: urlIcon,
                width: size,
                height: size,
                fit: BoxFit.contain,
                color: iconColor?.withOpacity(0.4),
              ),
            ),
          ),
        ),
        TextWidget(
          title,
          fontFamily: fontFamily,
          color: titleColor.withOpacity(0.4),
          fontWeight: TextWidgetWeight.medium,
          dsize: RelSize(size: TextWidgetSizes.xsmall),
        ),
      ],
    );
  }

  Widget _selectedWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: size,
          height: size,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              elevation: 0.0,
              padding: const EdgeInsets.all(0.0),
              backgroundColor: activeButtonColor,
              foregroundColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
            onPressed: () => onPressed(),
            child: Container(
              margin: EdgeInsets.all(size * 0.2),
              child: SvgIconNetworkWidget(
                path: urlIcon,
                width: size,
                height: size,
                fit: BoxFit.contain,
                color: activeIconColor,
              ),
            ),
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
