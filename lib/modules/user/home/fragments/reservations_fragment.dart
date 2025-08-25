import 'package:animate_do/animate_do.dart';
import 'package:bukeet/assets/app_assets.dart';
import 'package:bukeet/modules/user/home/controllers/reservations_user_fragment_controller.dart';
import 'package:bukeet/services/models/reservation.dart';
import 'package:bukeet/utils/app/app_margin.dart';
import 'package:bukeet/utils/app/app_size.dart';
import 'package:bukeet/utils/global/apply_opacity_util.dart';
import 'package:bukeet/widgets/loading/loading_data_widget.dart';
import 'package:bukeet/widgets/responsive/responsive_widget.dart';
import 'package:bukeet/widgets/responsive/web_frame_widget.dart';
import 'package:bukeet/widgets/svg/svg_asset_widget.dart';
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
      child: SafeArea(
        child: Container(
          width: AppSize.width(),
          height: AppSize.height(),
          margin: EdgeInsets.symmetric(
            vertical: AppMargin.vertical(),
            horizontal: AppMargin.horizontal(),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //_titleWidget(),
              (controller.isLoadData.value)
                  ? _fieldsListWidget()
                  : SizedBox(
                      height: AppSize.height() * 0.8,
                      child: LoadingDataWidget(),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  /*Widget _titleWidget() {
    return TextWidget(
      'Tus Reservas',
      fontFamily: AppFontFamily.leagueSpartan,
      fontWeight: TextWidgetWeight.bold,
    );
  }*/

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
            height: AppSize.height() * 0.9,
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: controller.reservations.length,

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
     var icon = item.paymentStatus == "APPROVED"
        ? AppIcons.field
        : item.paymentStatus == "DECLINED"
        ? AppIcons.fieldFailed
        : AppIcons.fieldPending;
    return Container(
      width: AppSize.width() * 0.85,
      padding: EdgeInsets.all(AppMargin.horizontal() * 0.5),
      decoration: BoxDecoration(
        color: controller.theme.background.value,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: applyOpacity(controller.theme.gray.value, (0.5)),
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: applyOpacity(controller.theme.gray.value, (0.1)),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            width: AppSize.width() * 0.9,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        SvgAssetWidget(
                          width: AppSize.width() * 0.05,
                          height: AppSize.width() * 0.05,
                          path: icon,
                        ),
                        _infoBoldText('${item.fieldOrder ?? 0}'),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _infoBoldText('${item.arenaName ?? 0}'),
                        _infoText(DateFormat('dd MMM yyyy').format(item.date!)),
                      ],
                    ),
                    const SizedBox(),
                    _infoText(' ${controller.formatHour(item.timeSlot ?? 0)}'),
                  ],
                ),
                Divider(color: controller.theme.gray.value, thickness: 0.5),
                _textWithIconWidget(item),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoText(String text) {
    return TextWidget(
      text,
      fontFamily: AppFontFamily.leagueSpartan,
      fontWeight: TextWidgetWeight.normal,
    );
  }

  Widget _infoBoldText(String text) {
    return TextWidget(
      text,
      fontFamily: AppFontFamily.leagueSpartan,
      fontWeight: TextWidgetWeight.extraBold,
    );
  }

  Widget _textWithIconWidget(Reservation item) {
    var statusText = item.paymentStatus == "APPROVED"
        ? 'Confirmada'
        : item.paymentStatus == "DECLINED"
        ? 'Fallida'
        : 'Pendiente';
    var statusColor = item.paymentStatus == "APPROVED"
        ? controller.theme.greenSolidPayment.value
        : item.paymentStatus == "DECLINED"
        ? controller.theme.redSolidPayment.value
        : controller.theme.yellowSolidPayment.value;
    var icon = item.paymentStatus == "APPROVED"
        ? AppIcons.check
        : item.paymentStatus == "DECLINED"
        ? AppIcons.failed
        : AppIcons.pending;
    return Row(
      children: [
        SvgAssetWidget(
          width: AppSize.width() * 0.05,
          height: AppSize.width() * 0.05,
          color: statusColor,
          path: icon,
        ),
        SizedBox(width: AppSize.width() * 0.02),
        TextWidget(
          statusText,
          fontFamily: AppFontFamily.leagueSpartan,
          fontWeight: TextWidgetWeight.bold,
          color: statusColor,
        ),
      ],
    );
  }
}
