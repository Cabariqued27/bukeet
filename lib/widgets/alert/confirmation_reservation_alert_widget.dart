import 'package:bukeet/theme/theme.dart';
import 'package:bukeet/utils/app/app_margin.dart';
import 'package:bukeet/utils/app/app_size.dart';
import 'package:bukeet/utils/buttons/gradient_button_widget.dart';
import 'package:bukeet/utils/buttons/single_button_widget.dart';
import 'package:bukeet/widgets/text/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConfirmReservationAlertWidget extends StatelessWidget {
  final String date;
  final String hour;
  final String location;
  final String price;

  final VoidCallback positiveAction;
  final VoidCallback negativeAction;

  ConfirmReservationAlertWidget({
    super.key,
    required this.date,
    required this.hour,
    required this.location,
    required this.price,
    required this.positiveAction,
    required this.negativeAction,
  });

  final _theme = Get.find<AppTheme>();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppSize.width(),
      margin: EdgeInsets.symmetric(
        vertical: AppMargin.vertical(),
        horizontal: AppMargin.horizontal(),
      ),
      padding: EdgeInsets.all(AppMargin.vertical() * 0.7),
      decoration: BoxDecoration(
        color: _theme.background.value,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildText('reservation_data'),
          _buildRow('date'.tr, date),
          _buildRow('hour'.tr, hour),
          _buildRow('location'.tr, location),
          _buildRow('price'.tr, price),
          SizedBox(height: AppSize.height() * 0.02),
          Row(
            children: [
              _buildButton(
                GradientButtonWidget(
                  fontFamily: AppFontFamily.workSans,
                  gradient: _theme.refreshBackgroundExplore.value,
                  disableColor: _theme.disable.value,
                  textColor: _theme.text.value,
                  onPressed: positiveAction,
                  title: 'confirm'.tr,
                  isActive: true,
                  height: 50.0,
                ),
              ),
              SizedBox(width: AppSize.width() * 0.02),
              _buildButton(
                SingleButtonWidget(
                  fontFamily: AppFontFamily.workSans,
                  backgroundColor: _theme.onBackground.value,
                  borderColor: _theme.onText.value,
                  textColor: _theme.text.value,
                  onPressed: negativeAction,
                  title: 'cancel'.tr,
                  isActive: true,
                  height: 50.0,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRow(String label, String value) {
    return Row(
      children: [
        _buildText(label),
        _buildText(value),
      ],
    );
  }

  Widget _buildText(String text) {
    return TextWidget(
      text.tr,
      fontFamily: AppFontFamily.leagueSpartan,
      color: _theme.text.value,
      dsize: RelSize(size: TextWidgetSizes.small),
      fontWeight: TextWidgetWeight.bold,
      textOverflow: TextOverflow.clip,
      textAlign: TextAlign.center,
    );
  }

  Widget _buildButton(Widget button) {
    return Expanded(child: button);
  }
}
