import 'package:animate_do/animate_do.dart';
import 'package:bukeet/modules/user/arena/controllers/booking_controller.dart';
import 'package:bukeet/utils/app/app_margin.dart';
import 'package:bukeet/utils/app/app_size.dart';
import 'package:bukeet/widgets/buttons/border_button_widget.dart';
import 'package:bukeet/widgets/images/network_image_widget.dart';
import 'package:bukeet/widgets/inputs/date_input_default_widget.dart';
import 'package:bukeet/widgets/loading/loading_data_widget.dart';
import 'package:bukeet/widgets/responsive/responsive_widget.dart';
import 'package:bukeet/widgets/responsive/web_frame_widget.dart';
import 'package:bukeet/widgets/text/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookingPage extends StatelessWidget {
  final BookingController controller;

  const BookingPage({
    super.key,
    required this.controller,
  });

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
      ),
    );
  }

  Widget _pageWidget() {
    return SizedBox(
      width: AppSize.width(),
      height: AppSize.height(),
      child: Stack(
        children: [
          Container(
            width: AppSize.width(),
            height: AppSize.height(),
            margin: EdgeInsets.symmetric(
              vertical: AppMargin.vertical(),
              horizontal: AppMargin.horizontal(),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(),
                _nameWidget(),
                _imagesWidget(),
                const SizedBox(),
                (controller.isLoadDataReservations.value)
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _dateInputWidget(),
                          _availableTimesDropdownWidget(),
                          SizedBox(height: AppSize.height() * 0.05),
                          _sendReservationButton(),
                        ],
                      )
                    : LoadingDataWidget(),
                const SizedBox(),
                const SizedBox(),
                const SizedBox(),
                const SizedBox(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _nameWidget() {
    return FadeIn(
      duration: const Duration(milliseconds: 1000),
      child: TextWidget(
        controller.arenaInformation?.name ?? '',
        fontFamily: AppFontFamily.leagueSpartan,
        fontWeight: FontWeight.w600,
        dsize: RelSize(size: TextWidgetSizes.normal),
        color: controller.theme.black.value,
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _imagesWidget() {
    return FadeIn(
      duration: const Duration(milliseconds: 1000),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: NetworkImageWidget(
              imageUrl: controller.fieldInformation?.images?[0] ?? '',
              width: AppSize.width() * 0.9,
              height: AppSize.width() * 0.6,
            ),
          ),
          _informationWidget()
        ],
      ),
    );
  }

  Widget _informationWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextWidget(
          controller.arenaInformation?.city ?? '',
          fontFamily: AppFontFamily.leagueSpartan,
          fontWeight: FontWeight.w600,
          dsize: RelSize(size: TextWidgetSizes.normal),
          color: controller.theme.black.value,
          textAlign: TextAlign.center,
        ),
        TextWidget(
          controller.arenaInformation?.address ?? '',
          fontFamily: AppFontFamily.leagueSpartan,
          fontWeight: FontWeight.w600,
          dsize: RelSize(size: TextWidgetSizes.normal),
          color: controller.theme.black.value,
          textAlign: TextAlign.center,
        ),
        TextWidget(
          '${controller.fieldInformation?.players} vs ${controller.fieldInformation?.players}',
          fontFamily: AppFontFamily.leagueSpartan,
          fontWeight: FontWeight.w600,
          textAlign: TextAlign.center,
          dsize: RelSize(
            size: TextWidgetSizes.normal,
          ),
          color: controller.theme.black.value,
        ),
      ],
    );
  }

  Widget _availableTimesDropdownWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _textInputWidget('avaliable_hours', controller.theme.black.value),
        Container(
          width: AppSize.width() * 0.9,
          height: AppSize.height() * 0.06,
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          decoration: BoxDecoration(
            color: controller.theme.white.value,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(
              color: controller.theme.grayAccent.value,
              width: 1.0,
            ),
          ),
          child: DropdownButton<String>(
            isExpanded: true,
            underline: const SizedBox(),
            focusColor: controller.theme.backgroundDeviceSetting.value,
            hint: TextWidget(
              fontStyle: FontStyle.italic,
              'choose_hour'.tr,
              fontFamily: AppFontFamily.workSans,
              textAlign: TextAlign.center,
              dsize: RelSize(
                size: TextWidgetSizes.small,
              ),
              color: controller.theme.onText.value,
            ),
            value: controller.selectedHour.value.isEmpty
                ? null
                : controller.selectedHour.value,
            items: controller.listAvailableTimes.map((String gender) {
              return DropdownMenuItem<String>(
                value: gender,
                child: TextWidget(
                  gender,
                  fontFamily: AppFontFamily.workSans,
                  textAlign: TextAlign.center,
                  dsize: RelSize(
                    size: TextWidgetSizes.small,
                  ),
                  color: controller.theme.gray.value,
                ),
              );
            }).toList(),
            onChanged: (String? newGender) {
              if (newGender != null) {
                controller.setSelectedHour(newGender);
                var index = controller.listAvailableTimes.indexOf(newGender);
                controller.setSelectedPrice(
                    controller.listPriceAvailableTimes[index]);
              }
            },
          ),
        ),
      ],
    );
  }

  Widget _dateInputWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _textInputWidget(
            'choose_reservation_date', controller.theme.black.value),
        GestureDetector(
          onTap: () => controller.chooseDate(),
          child: DateInputDefaultWidget(
            defaultDate: controller.todayDynamic.value,
            hintText: 'hint_date'.tr,
            textInputType: TextInputType.text,
            controller: controller.dateController,
            onChanged: (value) => (),
          ),
        ),
      ],
    );
  }

  Widget _sendReservationButton() {
    return BorderButtonWidget(
      fontFamily: AppFontFamily.workSans,
      textSize: TextWidgetSizes.small,
      onPressed: () {
        controller.confirmReservation();
      },
      isActive: controller.activateNext.value,
      height: 55.0,
      width: AppSize.width() * 0.5,
      title: 'book&play_button'.tr,
      backgroundColor: controller.theme.exploreRefresh.value,
      textColor: controller.theme.black.value,
    );
  }

  Widget _textInputWidget(String text, Color color) {
    return TextWidget(
      text.tr,
      fontFamily: AppFontFamily.workSans,
      textAlign: TextAlign.center,
      fontWeight: TextWidgetWeight.medium,
      dsize: RelSize(
        size: TextWidgetSizes.xsmall,
      ),
      color: color,
    );
  }
}
