import 'package:bukeet/theme/theme.dart';
import 'package:bukeet/utils/app/app_margin.dart';
import 'package:bukeet/utils/app/app_size.dart';
import 'package:bukeet/utils/buttons/gradient_button_widget.dart';
import 'package:bukeet/widgets/text/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MessageAlertWidget extends StatelessWidget {
  final String title;
  final String buttonTitle;
  final VoidCallback onPressed;

  MessageAlertWidget({
    super.key,
    required this.title,
    required this.buttonTitle,
    required this.onPressed,
  });

  final _theme = Get.find<AppTheme>();

  @override
  Widget build(BuildContext context) {
    return _widgerContent();
  }

  Widget _widgerContent() {
    return Container(
      width: AppSize.width(),
      margin: EdgeInsets.symmetric(
        vertical: AppMargin.vertical(),
        horizontal: AppMargin.horizontal(),
      ),
      padding: EdgeInsets.all(
        AppMargin.vertical() * 0.7,
      ),
      decoration: BoxDecoration(
        color: _theme.background.value,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextWidget(
            title,
            fontFamily: AppFontFamily.leagueSpartan,
            color: _theme.text.value,
            dsize: RelSize(
              size: TextWidgetSizes.small,
            ),
            fontWeight: TextWidgetWeight.bold,
            textOverflow: TextOverflow.clip,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: AppSize.height() * 0.02),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buttonWidget(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buttonWidget() {
    return Expanded(
      child: GradientButtonWidget(
        fontFamily: AppFontFamily.workSans,
        gradient: _theme.refreshCongratulationColor.value,
        disableColor: _theme.disable.value,
        textColor: _theme.text.value,
        onPressed: () => onPressed(),
        title: buttonTitle,
        isActive: true,
        height: 50.0,
      ),
    );
  }
}
