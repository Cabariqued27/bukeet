import 'package:bukeet/assets/app_assets.dart';
import 'package:bukeet/modules/fieldOwner/fieldOwnerAdmin/controllers/edit_field_admin_controller.dart';
import 'package:bukeet/services/models/hour_data.dart';
import 'package:bukeet/utils/app/app_margin.dart';
import 'package:bukeet/utils/app/app_size.dart';
import 'package:bukeet/utils/buttons/gradient_button_widget.dart';
import 'package:bukeet/widgets/buttons/svg_icon_button_widget.dart';
import 'package:bukeet/widgets/list/hour_avaliability.dart';
import 'package:bukeet/widgets/responsive/responsive_widget.dart';
import 'package:bukeet/widgets/responsive/web_frame_widget.dart';
import 'package:bukeet/widgets/text/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:math' as math;

class EditFieldAdminPage extends StatelessWidget {
  final EditFieldAdminController controller;

  const EditFieldAdminPage({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      desktop: WebFrameWidget(
        child: _mobileContent(),
      ),
      tablet: WebFrameWidget(
        child: _mobileContent(),
      ),
      mobile: _mobileContent(),
    );
  }

  Widget _mobileContent() {
    return Obx(
      () => Scaffold(
        body: _pageWidget(),
        backgroundColor: controller.theme.background.value,
        bottomNavigationBar: _updateButtonWidget(),
      ),
    );
  }

  Widget _pageWidget() {
    return Obx(
      () => Scaffold(
        backgroundColor: controller.theme.background.value,
        body: SafeArea(
          child: Container(
            width: AppSize.width(),
            height: AppSize.height(),
            margin: EdgeInsets.symmetric(
              vertical: AppMargin.vertical(),
              horizontal: AppMargin.horizontal(),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _titleWidget(),
                _daySelectorWidget(),
                _hourListForDay(
                    controller.daysOfWeek[controller.daysOfWeekIndex.value]),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _titleWidget() {
    return TextWidget(
      'edit_field_schedule'.tr,
      fontFamily: AppFontFamily.leagueSpartan,
      fontWeight: TextWidgetWeight.bold,
    );
  }

  Widget _hourListForDay(String day) {
  final hourList = controller.getHourDataForDay(day);
  return Expanded(
    child: ListView.builder(
      itemCount: hourList.length,
      itemBuilder: (context, index) {
        final hourData = hourList[index];
        return HourAvailabilityTile(
          hour: hourData.hour,
          isActive: hourData.isActive,
          price: hourData.price,
          theme: controller.theme,
          onToggleActive: (newStatus) {
            hourList[index] = HourData(
              hour: hourData.hour,
              isActive: newStatus,
              price: hourData.price,
            );
            controller.updateHourDataForDay(day, List.from(hourList));
          },
          onPriceChanged: (value) {
            final newPrice = value;
            hourList[index] = HourData(
              hour: hourData.hour,
              isActive: hourData.isActive,
              price: newPrice,
            );
            controller.updateHourDataForDay(day, List.from(hourList));
          },
        );
      },
    ),
  );
}


  Widget _daySelectorWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SvgIconButtonWidget(
            size: 10,
            icon: AppIcons.leftArrowSettings,
            color: controller.theme.black.value,
            onPressed: () => controller.decreaseSelectedDay()),
        TextWidget(controller.daysOfWeek[controller.daysOfWeekIndex.value].tr,
            fontFamily: AppFontFamily.leagueSpartan,
            fontWeight: TextWidgetWeight.bold,
            color: controller.theme.greenMin.value),
        Transform.rotate(
          angle: math.pi,
          child: SvgIconButtonWidget(
            size: 10,
            icon: AppIcons.leftArrowSettings,
            color: controller.theme.black.value,
            onPressed: () => controller.increaseSelectedDay(),
          ),
        )
      ],
    );
  }

  Widget _updateButtonWidget() {
    return Container(
      padding: EdgeInsets.only(
          bottom: AppMargin.vertical(),
          left: AppMargin.horizontal(),
          right: AppMargin.horizontal()),
      child: GradientButtonWidget(
        gradient: controller.theme.refreshBackgroundExplore.value,
        disableColor: controller.theme.disable.value,
        textColor: controller.theme.text.value,
        onPressed: () async {
          controller.updateSchedule();
        },
        isActive: true,
        title: 'update_schedule'.tr,
        height: 50.0,
        width: double.infinity,
        fontFamily: AppFontFamily.workSans,
      ),
    );
  }
}
