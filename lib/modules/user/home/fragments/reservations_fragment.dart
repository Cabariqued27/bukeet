import 'package:animate_do/animate_do.dart';
import 'package:bukeet/modules/user/home/controllers/reservations_user_fragment_controller.dart';
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

class ReservationsUserFragment extends StatelessWidget {
  final ReservationsUserFragmentController controller;

  const ReservationsUserFragment({super.key, required this.controller});

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
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(height: AppSize.width() * 0.15),
                _titleWidget(),
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

  Widget _titleWidget() {
    return TextWidget(
      'Tus Reservas',
      fontFamily: AppFontFamily.leagueSpartan,
      fontWeight: TextWidgetWeight.bold,
    );
  }

  Widget _fieldsListWidget() {
    return Expanded(
      child: RefreshIndicator(
        color: controller.theme.refreshColor.value,
        backgroundColor: controller.theme.background.value,
        onRefresh: () async {
          await controller.refreshData();
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
                    _fieldItemWidget(item),
                    SizedBox(height: AppSize.width() * 0.01),
                  ],
                );
              },
            ),
          ),
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
      width: AppSize.width() * 0.8,
      padding: EdgeInsets.only(left: AppMargin.horizontal() * 0.5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              SizedBox(
                width: AppSize.width() * 0.9,
                child: Column(
                  children: [
                    SizedBox(
                      width: AppSize.width() * 0.9,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          _infoText(
                            'Día: ${DateFormat('dd MMM yyyy').format(item.date!)}',
                          ),
                          _infoText('Hora: ${item.timeSlot}'),
                          _infoText('Cancha: ${item.fieldId}'),
                          _infoText(
                            'Estado: ${item.paymentStatus == "APPROVED" ? 'Confirmada' : 'Pendiente'}',
                          ),
                        ],
                      ),
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

  Widget _infoText(String text) {
    return TextWidget(
      text,
      fontFamily: AppFontFamily.leagueSpartan,
      fontWeight: TextWidgetWeight.bold,
    );
  }
}
