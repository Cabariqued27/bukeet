import 'package:animate_do/animate_do.dart';
import 'package:bukeet/modules/admin/home/controllers/reservations_admin_fragment_controller.dart';
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

class ReservationsAdminFragment extends StatelessWidget {
  final ReservationsAdminFragmentController controller;

  const ReservationsAdminFragment({
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: AppSize.width() * 0.15),
                (controller.isLoadData.value)
                    ? _fieldsListWidget()
                    : LoadingDataWidget()
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
          padding: EdgeInsets.only(bottom: AppMargin.vertical() * 3),
          itemCount: controller.reservations.length,
          itemBuilder: (context, index) {
            var item = controller.reservations[index];
            return InkWell(
                onTap: () {
                  controller.updateReservationStatus(item);
                },
                child: _fieldItemWidget(item));
          },
        ),
      ),
    );
  }

  Widget _fieldItemWidget(Reservation item) {
    return SizedBox(
      width: AppSize.width() * 0.8,
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
                    TextWidget(
                      'DÍA',
                      fontFamily: AppFontFamily.leagueSpartan,
                      fontWeight: TextWidgetWeight.bold,
                    ),
                    TextWidget(
                      DateFormat('dd-MM-yyyy').format(item.date!),
                      fontFamily: AppFontFamily.leagueSpartan,
                      fontWeight: TextWidgetWeight.normal,
                    ),
                    TextWidget(
                      'Hora',
                      fontFamily: AppFontFamily.leagueSpartan,
                      fontWeight: TextWidgetWeight.bold,
                    ),
                    TextWidget(
                      item.timeSlot.toString(),
                      fontFamily: AppFontFamily.leagueSpartan,
                      fontWeight: TextWidgetWeight.normal,
                    ),
                    TextWidget(
                      'Cancha',
                      fontFamily: AppFontFamily.leagueSpartan,
                      fontWeight: TextWidgetWeight.bold,
                    ),
                    TextWidget(
                      item.fieldId.toString(),
                      fontFamily: AppFontFamily.leagueSpartan,
                    ),
                    TextWidget(
                      'Estado',
                      fontFamily: AppFontFamily.leagueSpartan,
                      fontWeight: TextWidgetWeight.bold,
                    ),
                    TextWidget(
                      item.paymentStatus??'',
                      fontFamily: AppFontFamily.leagueSpartan,
                    ),
                  ],
                ),
              ),
              SizedBox(height: AppSize.width() * 0.1)
            ],
          ),
        ],
      ),
    );
  }
}
