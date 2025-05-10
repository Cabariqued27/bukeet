import 'package:animate_do/animate_do.dart';
import 'package:bukeet/modules/admin/home/controllers/home_admin_fragment_controller.dart';
import 'package:bukeet/services/models/field.dart';
import 'package:bukeet/utils/app/app_margin.dart';
import 'package:bukeet/utils/app/app_size.dart';
import 'package:bukeet/widgets/images/network_image_widget.dart';
import 'package:bukeet/widgets/loading/loading_data_widget.dart';
import 'package:bukeet/widgets/responsive/responsive_widget.dart';
import 'package:bukeet/widgets/responsive/web_frame_widget.dart';
import 'package:bukeet/widgets/text/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeAdminFragment extends StatelessWidget {
  final HomeAdminFragmentController controller;

  const HomeAdminFragment({
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
                TextWidget(
                  'Campos Registrados'.tr,
                  fontFamily: AppFontFamily.leagueSpartan,
                  fontWeight: TextWidgetWeight.bold,
                ),
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
          padding: EdgeInsets.only(bottom: AppMargin.vertical() * 2),
          scrollDirection: Axis.vertical,
          itemCount: controller.fields.length,
          itemBuilder: (context, index) {
            var item = controller.fields[index];
            return InkWell(
                //onTap: () => controller.doDooking(item),
                child: _fieldItemWidget(item));
          },
        ),
      ),
    );
  }

  Widget _fieldItemWidget(Field item) {
    return SizedBox(
      width: AppSize.width() * 0.8,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: NetworkImageWidget(
                  imageUrl: item.images?[0] ?? '',
                  width: AppSize.width() * 0.9,
                  height: AppSize.width() * 0.6,
                ),
              ),
              SizedBox(
                width: AppSize.width() * 0.9,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextWidget(
                      (item.id ?? 0).toString(),
                      fontFamily: AppFontFamily.leagueSpartan,
                      fontWeight: TextWidgetWeight.bold,
                    ),
                    TextWidget(
                      (item.arenaId ?? 0).toString(),
                      fontFamily: AppFontFamily.leagueSpartan,
                    ),
                  ],
                ),
              ),
              SizedBox(height: AppSize.width() * 0.03)
            ],
          ),
        ],
      ),
    );
  }
}
