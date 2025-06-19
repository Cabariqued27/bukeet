import 'package:animate_do/animate_do.dart';
import 'package:bukeet/assets/app_assets.dart';
import 'package:bukeet/modules/user/arena/controllers/booking_controller.dart';
import 'package:bukeet/services/models/institution.dart';
import 'package:bukeet/utils/app/app_margin.dart';
import 'package:bukeet/utils/app/app_size.dart';
import 'package:bukeet/widgets/buttons/border_button_widget.dart';
import 'package:bukeet/widgets/buttons/svg_icon_button_widget.dart';
import 'package:bukeet/widgets/images/network_image_widget.dart';
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

  const BookingPage({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      desktop: WebFrameWidget(child: _mobileContent()),
      tablet: WebFrameWidget(child: _mobileContent()),
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
      child: (controller.isLoadData.value)
          ? FadeIn(
              duration: const Duration(milliseconds: 1000),
              child: Stack(
                children: [
                  _imagesWidget(),
                  SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        SizedBox(height: AppSize.height() * 0.2),
                        Container(
                          decoration: BoxDecoration(
                            color: controller.theme.background.value,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(30.0),
                              topRight: Radius.circular(30.0),
                            ),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 6,
                                offset: const Offset(0, 0),
                                color: controller
                                    .theme
                                    .backgroundDeviceSetting
                                    .value,
                              ),
                            ],
                          ),
                          padding: EdgeInsets.only(
                            top: AppMargin.vertical() * 0.5,
                            left: AppMargin.horizontal() * 0.5,
                            right: AppMargin.horizontal() * 0.5,
                            bottom: AppMargin.vertical() * 1.1,
                          ),
                          width: AppSize.width(),
                          child: Column(
                            children: [
                              _informationWidget(),
                              _dateInputWidget(),
                              _availableTimesDropdownWidget(),
                              _institutionsDropdownWidget(),
                              _peopleTypeDropDownWidget(),
                              _inputWidget(
                                'put_name',
                                controller.fullNameInputController,
                                'full_name',
                                TextInputType.text,
                              ),
                              _inputWidget(
                                'put_email',
                                controller.customerEmailInputController,
                                'email_address',
                                TextInputType.emailAddress,
                              ),
                              _documentTypeDropDownWidget(),
                              _inputWidget(
                                'ccnumero',
                                controller.userLegalIdInputController,
                                'ccnumero',
                                TextInputType.number,
                              ),
                              SizedBox(height: AppSize.width() * 0.05),
                              _sendReservationButton(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          : LoadingDataWidget(),
    );
  }

  /*Widget _nameWidget() {
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
  }*/

  Widget _imagesWidget() {
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            NetworkImageWidget(
              imageUrl: controller.fieldInformation?.images?[0] ?? '',
              width: AppSize.width(),
              height: AppSize.width() * 0.7,
            ),
          ],
        ),
        _appBarWidget(),
      ],
    );
  }

  Widget _appBarWidget() {
    return Positioned(
      top: AppSize.height() * 0.05,
      left: AppSize.width() * 0.03,
      child: Container(
        width: AppSize.width() * 0.1,
        height: AppSize.width() * 0.1,
        decoration: BoxDecoration(
          color: controller.theme.backgroundProfile.value,
          shape: BoxShape.circle,
        ),
        padding: const EdgeInsets.all(8),
        child: SvgIconButtonWidget(
          size: AppSize.width() * 0.05,
          icon: AppIcons.leftArrowSettings,
          onPressed: () => Get.back(),
          color: controller.theme.black.value,
        ),
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
          dsize: RelSize(size: TextWidgetSizes.normal),
          color: controller.theme.black.value,
        ),
      ],
    );
  }

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
        controller.confirmReservation();
      },
      isActive: controller.activateNext.value,
      height: 55.0,
      width: AppSize.width() * 0.5,
      title: 'book_it'.tr,
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
      dsize: RelSize(size: TextWidgetSizes.xsmall),
      color: color,
    );
  }

  Widget _inputWidget(
    String hintText,
    TextEditingController controllerText,
    String title,
    TextInputType textInputType,
  ) {
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
          onChanged: (value) => controller.onChangeForm(),
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
          controller.setSelectedPrice(
            controller.listPriceAvailableTimes[index],
          );
        }
      },
      itemLabel: (hour) => controller.formatHour(hour),
    );
  }

  Widget _institutionsDropdownWidget() {
    return _customDropdownWidget<Institution>(
      titleKey: 'banks',
      selectedValue: controller.selectedInstitution.value,
      items: controller.listInstitutions,
      hintTextKey: 'choose_your_bank',
      onChanged: (Institution? institution) {
        if (institution != null) {
          controller.setSelectedInstitution(institution);
        }
      },
      itemLabel: (institution) => institution.nombre,
    );
  }

  Widget _peopleTypeDropDownWidget() {
    return _customDropdownWidget<String>(
      titleKey: 'people_type',
      selectedValue: controller.selectedPeopleType.value.isEmpty
          ? null
          : controller.selectedPeopleType.value,
      items: controller.peopleTypes,
      hintTextKey: 'select_people_type',
      onChanged: (String? newPeopleType) {
        if (newPeopleType != null) {
          controller.setSelectedPeopleType(newPeopleType);
        }
      },
      itemLabel: (peopleType) => peopleType,
    );
  }

  Widget _documentTypeDropDownWidget() {
    return _customDropdownWidget<String>(
      titleKey: 'document_type',
      selectedValue: controller.selectedDocumentType.value.isEmpty
          ? null
          : controller.selectedDocumentType.value,
      items: controller.documentsTypes,
      hintTextKey: 'select_document_type',
      onChanged: (String? newDocumentType) {
        if (newDocumentType != null) {
          controller.setSelectedDocumentType(newDocumentType);
        }
      },
      itemLabel: (documentType) => documentType,
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
