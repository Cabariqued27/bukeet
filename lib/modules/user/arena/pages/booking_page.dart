import 'package:animate_do/animate_do.dart';
import 'package:bukeet/modules/user/arena/controllers/booking_controller.dart';
import 'package:bukeet/services/models/institution.dart';
import 'package:bukeet/utils/app/app_margin.dart';
import 'package:bukeet/utils/app/app_size.dart';
import 'package:bukeet/widgets/buttons/border_button_widget.dart';
import 'package:bukeet/widgets/inputs/date_input_default_widget.dart';
import 'package:bukeet/widgets/inputs/single_input_widget.dart';
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
            child: (controller.isLoadDataReservations.value)
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const SizedBox(),
                      _nameWidget(),
                      //_imagesWidget(),
                      const SizedBox(),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _dateInputWidget(),
                          _availableTimesDropdownWidget(),
                          _institutionsDropdownWidget(),
                          _genderDropDownWidget(),
                          _inputWidget(
                              'put_name',
                              controller.fullNameInputController,
                              'full_name',
                              TextInputType.text),
                          _inputWidget(
                              'put_email',
                              controller.customerEmailInputController,
                              'email_address',
                              TextInputType.emailAddress),
                          _inputWidget(
                              'ccnumero',
                              controller.userLegalIdInputController,
                              'ccnumero',
                              TextInputType.number),
                          _sendReservationButton(),
                        ],
                      )
                    ],
                  )
                : LoadingDataWidget(),
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

  /*Widget _imagesWidget() {
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
  }*/

  /*Widget _informationWidget() {
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
  }*/

  Widget _dateInputWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _titleWidget('choose_reservation_date', controller.theme.black.value),
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
        controller.crearTransaccionPSE();
      },
      isActive: true,
      height: 55.0,
      width: AppSize.width() * 0.5,
      title: 'book&play_button'.tr,
      backgroundColor: controller.theme.exploreRefresh.value,
      textColor: controller.theme.black.value,
    );
  }

  Widget _titleWidget(String text, Color color) {
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

  Widget _inputWidget(String hintText, TextEditingController controllerText,
      String title, TextInputType textInputType) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _titleWidget(title, controller.theme.black.value),
        SingleInputWidget(
          maxLength: 15,
          mandatory: true,
          hintText: hintText.tr,
          textInputType: textInputType,
          controller: controllerText,
          onChanged: (value) {},
          onEditingComplete: () => //controller.onChangedFirstName
              (),
          isActive: true,
        ),
        /*TextWidget(
          'name_check'.tr,
          fontFamily: AppFontFamily.workSans,
          color: (controller.firstNameWarning.value)
              ? controller.theme.primary.value
              : Colors.transparent,
          textAlign: TextAlign.start,
          dsize: RelSize(
            size: TextWidgetSizes.xsmall,
          ),
          textOverflow: TextOverflow.clip,
        ),*/
      ],
    );
  }

  Widget _availableTimesDropdownWidget() {
    return _customDropdownWidget<int>(
      titleKey: 'avaliable_hours',
      selectedValue:
          controller.listAvailableTimes.contains(controller.selectedHour.value)
              ? controller.selectedHour.value
              : null,
      items: controller.listAvailableTimes,
      hintTextKey: 'choose_hour',
      onChanged: (int? newHour) {
        if (newHour != null) {
          controller.setSelectedHour(newHour);
          var index = controller.listAvailableTimes.indexOf(newHour);
          controller
              .setSelectedPrice(controller.listPriceAvailableTimes[index]);
        }
      },
      itemLabel: (hour) => controller.formatHour(hour),
    );
  }

  Widget _institutionsDropdownWidget() {
    return _customDropdownWidget<Institution>(
      titleKey: 'institutions',
      selectedValue: controller.selectedInstitution.value,
      items: controller.listInstitutions,
      hintTextKey: 'choose_institution',
      onChanged: (Institution? institution) {
        if (institution != null) {
          controller.setSelectedInstitution(institution);
        }
      },
      itemLabel: (institution) => institution.nombre,
    );
  }

  Widget _genderDropDownWidget() {
    return _customDropdownWidget<String>(
      titleKey: 'gender',
      selectedValue: controller.selectedGender.value.isEmpty
          ? null
          : controller.selectedGender.value,
      items: controller.genders,
      hintTextKey: 'select_gender',
      onChanged: (String? newGender) {
        if (newGender != null) {
          controller.setSelectedGender(newGender);
        }
      },
      itemLabel: (gender) => gender,
    );
  }

  Widget _customDropdownWidget<T>({
    required String titleKey,
    required T? selectedValue,
    required List<T> items,
    required String hintTextKey,
    required void Function(T?) onChanged,
    required String Function(T) itemLabel,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _titleWidget(titleKey, controller.theme.black.value),
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
          child: DropdownButton<T>(
            isExpanded: true,
            underline: const SizedBox(),
            focusColor: controller.theme.backgroundDeviceSetting.value,
            hint: TextWidget(
              fontStyle: FontStyle.italic,
              hintTextKey.tr,
              fontFamily: AppFontFamily.workSans,
              textAlign: TextAlign.center,
              dsize: RelSize(size: TextWidgetSizes.small),
              color: controller.theme.onText.value,
            ),
            value: selectedValue,
            items: items.map((T item) {
              return DropdownMenuItem<T>(
                value: item,
                child: TextWidget(
                  itemLabel(item),
                  fontFamily: AppFontFamily.workSans,
                  textAlign: TextAlign.center,
                  dsize: RelSize(size: TextWidgetSizes.small),
                  color: controller.theme.gray.value,
                ),
              );
            }).toList(),
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}
