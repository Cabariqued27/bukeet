import 'package:bukeet/assets/app_assets.dart';
import 'package:bukeet/modules/user/arena/controllers/booking_controller.dart';
import 'package:bukeet/services/models/institution.dart';
import 'package:bukeet/utils/app/app_margin.dart';
import 'package:bukeet/utils/app/app_size.dart';
import 'package:bukeet/utils/global/apply_opacity_util.dart';
import 'package:bukeet/widgets/buttons/border_button_widget.dart';
import 'package:bukeet/widgets/buttons/svg_icon_button_widget.dart';
import 'package:bukeet/widgets/images/full_slider_network_image_widget.dart';
import 'package:bukeet/widgets/inputs/date_input_default_widget.dart';
import 'package:bukeet/widgets/inputs/single_input_widget.dart';
import 'package:bukeet/widgets/loading/loading_data_widget.dart';
import 'package:bukeet/widgets/responsive/responsive_widget.dart';
import 'package:bukeet/widgets/responsive/web_frame_widget.dart';
import 'package:bukeet/widgets/text/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

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
        backgroundColor: controller.theme.backgroundDeviceSetting.value,
      ),
    );
  }

  Widget _pageWidget() {
    return SizedBox(
      width: AppSize.width(),
      height: AppSize.height(),
      child: (controller.isLoadData.value)
          ? (controller.bookingStateValue.value == BookingState.formPayment)
                ? _formPaymentWidget()
                : (controller.bookingStateValue.value ==
                      BookingState.pseGateway)
                ? Stack(
                    children: [
                      _webViewWidget(),
                      _appBarWidget(BookingState.formPayment),
                    ],
                  )
                : Stack(
                    children: [
                      _webViewTermsConditonsWidget(),
                      _appBarWidget(BookingState.formPayment),
                    ],
                  )
          : LoadingDataWidget(),
    );
  }

  Widget _webViewWidget() {
    return SafeArea(
      child: SizedBox(
        width: AppSize.width(),
        height: AppSize.height(),
        child: (controller.isPaymentCheckoutLoad.value)
            ? WebViewWidget(controller: controller.webViewController)
            : LoadingDataWidget(),
      ),
    );
  }

  Widget _imagesWidget() {
    return FullSliderNetworkImageWidget(
      images: controller.fieldInformation?.images ?? [],
    );
  }

  Widget _formPaymentWidget() {
    return (!controller.isPaymentCheckoutLoad.value)
        ? CustomScrollView(
            slivers: [
              SliverAppBar(
                pinned: false,
                expandedHeight: 275.0,
                elevation: 0.0,
                backgroundColor: Colors.transparent,
                flexibleSpace: FlexibleSpaceBar(background: _imagesWidget()),
                bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(0.0),
                  child: Container(
                    height: 20.0,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: controller.theme.backgroundDeviceSetting.value,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(30.0),
                        topRight: Radius.circular(30.0),
                      ),
                    ),
                  ),
                ),
                leadingWidth: 80.0,
                leading: Container(
                  height: 30.0,
                  width: 30.0,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: controller.theme.backgroundDeviceSetting.value,
                  ),
                  child: SvgIconButtonWidget(
                    icon: AppIcons.leftArrow,
                    size: 15,
                    onPressed: () => Get.back(),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(height: AppSize.height() * 0.02),
                    _informationWidget(),
                    SizedBox(height: AppSize.height() * 0.02),
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

                    _termsAndConditionsWompi(),
                    _sendReservationButton(),
                    SizedBox(height: AppSize.width() * 0.05),
                  ],
                ),
              ),
            ],
          )
        : LoadingDataWidget();
  }

  Widget _appBarWidget(BookingState value) {
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
          onPressed: () => controller.updateBookingState(value),
          color: controller.theme.black.value,
        ),
      ),
    );
  }

  Widget _informationWidget() {
    return SizedBox(
      width: AppSize.width() * 0.9,
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextWidget(
                controller.arenaInformation?.city ?? '',
                fontFamily: AppFontFamily.leagueSpartan,
                fontWeight: FontWeight.w600,
                dsize: RelSize(size: TextWidgetSizes.normal),
                color: controller.theme.black.value,
                textAlign: TextAlign.center,
                height: 0.5,
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
                height: 0.5,
              ),
            ],
          ),
        ],
      ),
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
        const SizedBox(height: 6),
        LayoutBuilder(
          builder: (context, constraints) {
            final double dropdownWidth = constraints.maxWidth;

            return Container(
              width: AppSize.width() * 0.9,
              decoration: BoxDecoration(
                color: controller.theme.white.value,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: applyOpacity(
                      controller.theme.grayAccent.value,
                      0.25,
                    ),
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
                border: Border.all(
                  color: controller.theme.grayAccent.value,
                  width: 1,
                ),
              ),
              child: ButtonTheme(
                alignedDropdown: true,
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<T>(
                    isExpanded: true,
                    borderRadius: BorderRadius.circular(12),
                    dropdownColor: controller.theme.white.value,
                    icon: Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: controller.theme.gray.value,
                    ),
                    hint: TextWidget(
                      hintTextKey.tr,
                      fontFamily: AppFontFamily.workSans,
                      textAlign: TextAlign.start,
                      dsize: RelSize(size: TextWidgetSizes.buttonsTitle),
                      color: controller.theme.gray.value,
                    ),
                    value: selectedValue,
                    items: items.map((T item) {
                      return DropdownMenuItem<T>(
                        value: item,
                        child: ConstrainedBox(
                          constraints: BoxConstraints(maxWidth: dropdownWidth),
                          child: TextWidget(
                            itemLabel(item),
                            fontFamily: AppFontFamily.workSans,
                            textAlign: TextAlign.start,
                            dsize: RelSize(size: TextWidgetSizes.buttonsTitle),
                            color: controller.theme.black.value,
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: onChanged,
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _termsAndConditionsWompi() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.all(AppMargin.vertical() * 0.3),

      itemCount: controller.items.length,
      itemBuilder: (context, index) {
        final item = controller.items[index];
        return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Checkbox(
              activeColor: controller.theme.greenMin.value,
              visualDensity: const VisualDensity(vertical: 1),
              value: item.activate,
              onChanged: (_) => controller.toggleItem(index),
            ),
            Expanded(
              child: InkWell(
                onTap: () =>
                    controller.startWebViewTermsController(item.link ?? ''),
                child: TextWidget(
                  '${item.title}'.tr,
                  fontFamily: AppFontFamily.leagueSpartan,
                  fontWeight: FontWeight.w600,
                  dsize: RelSize(size: TextWidgetSizes.xsmall),
                  color: controller.theme.blueMin.value,
                  decoration: TextDecoration.underline,

                  maxLines: 2,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _webViewTermsConditonsWidget() {
    return SafeArea(
      child: SizedBox(
        width: AppSize.width(),
        height: AppSize.height(),
        child: (controller.isLoadDataTerms.value)
            ? WebViewWidget(
                controller: controller.webViewTermsConditionsController,
              )
            : LoadingDataWidget(),
      ),
    );
  }
}
