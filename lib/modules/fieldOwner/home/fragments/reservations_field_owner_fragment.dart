import 'package:animate_do/animate_do.dart';
import 'package:bukeet/assets/app_assets.dart';
import 'package:bukeet/modules/fieldOwner/home/controllers/reservations_field_owner_fragment_controller.dart';
import 'package:bukeet/services/models/field.dart';
import 'package:bukeet/services/models/reservation.dart';
import 'package:bukeet/utils/app/app_margin.dart';
import 'package:bukeet/utils/app/app_size.dart';
import 'package:bukeet/widgets/buttons/border_button_widget.dart';
import 'package:bukeet/widgets/buttons/svg_icon_button_widget.dart';
import 'package:bukeet/widgets/loading/loading_data_widget.dart';
import 'package:bukeet/widgets/responsive/responsive_widget.dart';
import 'package:bukeet/widgets/responsive/web_frame_widget.dart';
import 'package:bukeet/widgets/text/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ReservationsFieldOwnerFragment extends StatelessWidget {
  final ReservationsFieldOwnerFragmentController controller;

  const ReservationsFieldOwnerFragment({super.key, required this.controller});

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
      child: SafeArea(
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [_titleWidget(), _filtersWidget()],
              ),
              (controller.isLoadData.value)
                  ? /*_fieldsListWidget()*/ _reservationByDayListWidget()
                  : SizedBox(
                      height: AppSize.height() * 0.7,
                      child: LoadingDataWidget(),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _titleWidget() {
    return TextWidget(
      'Reservas',
      fontFamily: AppFontFamily.leagueSpartan,
      fontWeight: TextWidgetWeight.bold,
    );
  }

  Widget _filtersWidget() {
    return SvgIconButtonWidget(
      icon: AppIcons.filter,
      size: 30,
      onPressed: () {
        showModalBottomSheet(
          context: Get.context!,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (_) {
            return Obx(() {
              return _filtersWidgetModal();
            });
          },
        );
      },
    );
  }

  Widget _filtersWidgetModal() {
    return Container(
      height: AppSize.height() * 0.3,
      padding: EdgeInsets.all(AppMargin.horizontal()),
      decoration: BoxDecoration(
        color: controller.theme.background.value,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,

        children: [
          Container(
            width: 40,
            height: 5,
            margin: const EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
              color: controller.theme.datePickerIconColor.value,
              borderRadius: BorderRadius.circular(10),
            ),
          ),

          TextWidget(
            'Filtrar por día y cancha',
            fontFamily: AppFontFamily.leagueSpartan,
            fontWeight: TextWidgetWeight.bold,
          ),
          const SizedBox(),
          _daySelectorWidget(),
          const SizedBox(),
          const SizedBox(),
          const SizedBox(),
          BorderButtonWidget(
            textSize: TextWidgetSizes.small,
            fontFamily: AppFontFamily.workSans,
            backgroundColor: controller.theme.white.value,
            borderColor: controller.theme.itemBorder.value,
            textColor: controller.theme.textStarted.value,
            onPressed: () => controller.resetDay(),
            title: 'close'.tr,
            isActive: true,
            height: 30.0,
            width: AppSize.width() * 0.3,
          ),
          const SizedBox(),
        ],
      ),
    );
  }

  Widget _drop() {
    return DropdownButton<Field>(
      value: controller.selectedField.value,
      elevation: 5,
      style: const TextStyle(color: Colors.white),
      iconEnabledColor: Colors.black,
      focusColor: Colors.white,

      items: controller.fields.map((field) {
        return DropdownMenuItem<Field>(
          value: field,
          child: TextWidget(
            'Cancha ${field.order}',
            fontFamily: AppFontFamily.leagueSpartan,
            fontWeight: TextWidgetWeight.normal,
            dsize: RelSize(size: TextWidgetSizes.small),
          ),
        );
      }).toList(),
      onChanged: (value) {
        if (value != null) {
          controller.updateFieldSelected(value);
        }
      },
    );
  }

  Widget _daySelectorWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SvgIconButtonWidget(
          icon: AppIcons.leftArrow,
          size: 10,
          onPressed: () => controller.decreaseDay(),
        ),
        Column(
          children: [
            _drop(),
            TextWidget(
              DateFormat('dd-MM-yyyy').format(controller.today.value),
              fontFamily: AppFontFamily.leagueSpartan,
              fontWeight: TextWidgetWeight.bold,
            ),
          ],
        ),
        Transform.flip(
          flipX: true,
          child: SvgIconButtonWidget(
            icon: AppIcons.leftArrow,
            size: 10,
            onPressed: () => controller.increaseDay(),
          ),
        ),
      ],
    );
  }

  Widget _reservationByDayListWidget() {
    return RefreshIndicator(
      color: controller.theme.refreshColor.value,
      backgroundColor: controller.theme.background.value,
      onRefresh: () async {
        //controller.startController();
      },
      child: FadeIn(
        duration: const Duration(milliseconds: 1000),
        child: SizedBox(
          height: AppSize.height() * 0.8,
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: controller.reservations.length,
            padding: EdgeInsets.only(bottom: AppMargin.vertical() * 3),
            itemBuilder: (context, index) {
              var item = controller.reservations[index];
              return Column(
                children: [
                  SizedBox(height: AppSize.width() * 0.05),
                  InkWell(
                    onTap: () {
                      controller.updateReservationStatus(item);
                    },
                    child: _reservationItemWidget(item),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _reservationItemWidget(Reservation item) {
    return Container(
      decoration: BoxDecoration(
        color: (item.paymentStatus == "APPROVED")
            ? controller.theme.exploreRefresh.value
            : controller.theme.exploreFocus.value,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      width: AppSize.width() * 0.9,
      padding: EdgeInsets.only(left: AppMargin.horizontal() * 0.5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              SizedBox(
                width: AppSize.width() * 0.9,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        TextWidget(
                          'Día: ',
                          fontFamily: AppFontFamily.leagueSpartan,
                          fontWeight: TextWidgetWeight.bold,
                        ),
                        TextWidget(
                          DateFormat(
                            'EEEE ',
                          ).format(item.date ?? controller.today.value),
                          fontFamily: AppFontFamily.leagueSpartan,
                          fontWeight: TextWidgetWeight.normal,
                        ),
                        TextWidget(
                          DateFormat(
                            'dd-MM-yyyy',
                          ).format(item.date ?? controller.today.value),
                          fontFamily: AppFontFamily.leagueSpartan,
                          fontWeight: TextWidgetWeight.normal,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        TextWidget(
                          'Hora: ',
                          fontFamily: AppFontFamily.leagueSpartan,
                          fontWeight: TextWidgetWeight.bold,
                        ),
                        TextWidget(
                          controller.formatHour(item.timeSlot ?? 0),
                          fontFamily: AppFontFamily.leagueSpartan,
                          fontWeight: TextWidgetWeight.normal,
                        ),
                      ],
                    ),
                    /*Row(
                      children: [
                        TextWidget(
                          'Location: ',
                          fontFamily: AppFontFamily.leagueSpartan,
                          fontWeight: TextWidgetWeight.bold,
                        ),
                        TextWidget(
                          controller.fieldIdToArenaName[item.fieldId] ?? '',
                          fontFamily: AppFontFamily.leagueSpartan,
                          fontWeight: TextWidgetWeight.normal,
                        ),
                      ],
                    ),*/
                    Row(
                      children: [
                        TextWidget(
                          'Cancha: ',
                          fontFamily: AppFontFamily.leagueSpartan,
                          fontWeight: TextWidgetWeight.bold,
                        ),
                        TextWidget(
                          '${item.fieldId ?? 7}',
                          fontFamily: AppFontFamily.leagueSpartan,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        TextWidget(
                          'Estado: ',
                          fontFamily: AppFontFamily.leagueSpartan,
                          fontWeight: TextWidgetWeight.bold,
                        ),
                        TextWidget(
                          item.paymentStatus ?? '',
                          fontFamily: AppFontFamily.leagueSpartan,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /*Widget _fieldsListWidget() {
    return RefreshIndicator(
      color: controller.theme.refreshColor.value,
      backgroundColor: controller.theme.background.value,
      onRefresh: () async {
        controller.startController();
      },
      child: FadeIn(
        duration: const Duration(milliseconds: 1000),
        child: SizedBox(
          height: AppSize.height() * 0.8,
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: controller.reservations.length,
            padding: EdgeInsets.only(bottom: AppMargin.vertical() * 3),
            itemBuilder: (context, index) {
              var item = controller.reservations[index];
              return Column(
                children: [
                  SizedBox(height: AppSize.width() * 0.05),
                  InkWell(
                    onTap: () {
                      controller.updateReservationStatus(item);
                    },
                    child: _fieldItemWidget(item),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }*/

  /*Widget _fieldItemWidget(Reservation item) {
    return Container(
      decoration: BoxDecoration(
        color: (item.paymentStatus == "APPROVED")
            ? controller.theme.exploreRefresh.value
            : controller.theme.exploreFocus.value,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      width: AppSize.width() * 0.9,
      padding: EdgeInsets.only(left: AppMargin.horizontal() * 0.5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              SizedBox(
                width: AppSize.width() * 0.9,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        TextWidget(
                          'Día: ',
                          fontFamily: AppFontFamily.leagueSpartan,
                          fontWeight: TextWidgetWeight.bold,
                        ),
                        TextWidget(
                          DateFormat('EEEE ').format(item.date!),
                          fontFamily: AppFontFamily.leagueSpartan,
                          fontWeight: TextWidgetWeight.normal,
                        ),
                        TextWidget(
                          DateFormat('dd-MM-yyyy').format(item.date!),
                          fontFamily: AppFontFamily.leagueSpartan,
                          fontWeight: TextWidgetWeight.normal,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        TextWidget(
                          'Hora: ',
                          fontFamily: AppFontFamily.leagueSpartan,
                          fontWeight: TextWidgetWeight.bold,
                        ),
                        TextWidget(
                          controller.formatHour(item.timeSlot ?? 0),
                          fontFamily: AppFontFamily.leagueSpartan,
                          fontWeight: TextWidgetWeight.normal,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        TextWidget(
                          'Location: ',
                          fontFamily: AppFontFamily.leagueSpartan,
                          fontWeight: TextWidgetWeight.bold,
                        ),
                        TextWidget(
                          controller.fieldIdToArenaName[item.fieldId] ?? '',
                          fontFamily: AppFontFamily.leagueSpartan,
                          fontWeight: TextWidgetWeight.normal,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        TextWidget(
                          'Cancha: ',
                          fontFamily: AppFontFamily.leagueSpartan,
                          fontWeight: TextWidgetWeight.bold,
                        ),
                        TextWidget(
                          item.fieldId.toString(),
                          fontFamily: AppFontFamily.leagueSpartan,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        TextWidget(
                          'Estado: ',
                          fontFamily: AppFontFamily.leagueSpartan,
                          fontWeight: TextWidgetWeight.bold,
                        ),
                        TextWidget(
                          item.paymentStatus ?? '',
                          fontFamily: AppFontFamily.leagueSpartan,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }*/

  /*Widget _fieldTabsWidget() {
    return FadeIn(
      duration: const Duration(milliseconds: 1000),
      child: Container(
        color: controller.theme.black.value,
        height: AppSize.height() * 0.1,
        width: AppSize.width(),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(controller.fields.length, (index) {
              var item = controller.fields[index];
              return Container(
                width: AppSize.width() / controller.fields.length,
                alignment: Alignment.center,
                color: controller.theme.redSolid.value,
                child: TextWidget(
                  (item.id ?? 0).toString(),
                  fontFamily: AppFontFamily.leagueSpartan,
                  fontWeight: TextWidgetWeight.bold,
                ),
              );
            }),
          ),
        ),
      ),
    );
  }*/
}
