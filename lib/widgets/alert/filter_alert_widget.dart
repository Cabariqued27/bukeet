import 'package:bukeet/theme/theme.dart';
import 'package:bukeet/utils/app/app_margin.dart';
import 'package:bukeet/utils/app/app_size.dart';
import 'package:bukeet/utils/buttons/single_button_widget.dart';
import 'package:bukeet/widgets/buttons/border_button_widget.dart';
import 'package:bukeet/widgets/text/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationsPermissionAlertWidget extends StatelessWidget {
  NotificationsPermissionAlertWidget({super.key});

  final _theme = Get.find<AppTheme>();

  @override
  Widget build(BuildContext context) {
    return _widgerContent();
  }

  Widget _widgerContent() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: AppSize.width(),
          margin: EdgeInsets.only(top: AppMargin.vertical()),
          padding: EdgeInsets.all(AppMargin.vertical() * 0.7),
          decoration: BoxDecoration(
            color: _theme.backgroundDeviceSetting.value,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _textWidget(),

              _allowNotificationsButtonWidget(),

              _laterLocationButtonWidget(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _textWidget() {
    return Column(
      children: [
        TextWidget(
          'filter_by'.tr,
          fontFamily: AppFontFamily.leagueSpartan,
          color: _theme.grayDark.value,
          dsize: RelSize(size: TextWidgetSizes.normal),
          fontWeight: TextWidgetWeight.bold,
          textOverflow: TextOverflow.clip,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _allowNotificationsButtonWidget() {
    return BorderButtonWidget(
      fontFamily: AppFontFamily.workSans,
      textColor: _theme.textStarted.value,
      onPressed: () {},
      isActive: true,
      title: 'activate_notifications'.tr,
      height: 55.0,
      width: double.infinity,
      //leftIcon: AppIcons.bell,
      iconColor: _theme.rightArrorExploreColor.value,
      iconSize: 20,
      backgroundColor: _theme.white.value,
      borderColor: _theme.itemBorder.value,
    );
  }

  Widget _laterLocationButtonWidget() {
    return SingleButtonWidget(
      fontFamily: AppFontFamily.workSans,
      textColor: _theme.textStarted.value,
      onPressed: () {},
      isActive: true,
      title: 'maybe_later'.tr,
      height: 55.0,
      width: double.infinity,
      backgroundColor: _theme.backgroundDeviceSetting.value,
      borderColor: _theme.backgroundDeviceSetting.value,
    );
  }
}
