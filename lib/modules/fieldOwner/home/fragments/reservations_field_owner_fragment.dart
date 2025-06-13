import 'package:animate_do/animate_do.dart';
import 'package:bukeet/modules/fieldOwner/home/controllers/reservations_field_owner_fragment_controller.dart';
import 'package:bukeet/services/models/reservation.dart';
import 'package:bukeet/utils/app/app_margin.dart';
import 'package:bukeet/utils/app/app_size.dart';
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: AppSize.width() * 0.15),
                fieldTabsWidget(),
                (controller.isLoadData.value)
                    ? _fieldsListWidget()
                    : LoadingDataWidget(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _fieldsListWidget() {
    return FadeIn(
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
    );
  }

  Widget _fieldItemWidget(Reservation item) {
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
                          item.timeSlot.toString(),
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
                          item.paymentStatus??'',
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

  Widget fieldTabsWidget() {
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
  }
}
