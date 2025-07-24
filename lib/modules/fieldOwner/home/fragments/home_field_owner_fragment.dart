import 'package:animate_do/animate_do.dart';
import 'package:bukeet/assets/app_assets.dart';
import 'package:bukeet/modules/fieldOwner/home/controllers/home_field_owner_fragment_controller.dart';
import 'package:bukeet/services/models/arena.dart';
import 'package:bukeet/utils/app/app_margin.dart';
import 'package:bukeet/utils/app/app_size.dart';
import 'package:bukeet/widgets/buttons/icons_solid_button_widget.dart';
import 'package:bukeet/widgets/images/network_image_widget.dart';
import 'package:bukeet/widgets/loading/loading_data_widget.dart';
import 'package:bukeet/widgets/responsive/responsive_widget.dart';
import 'package:bukeet/widgets/responsive/web_frame_widget.dart';
import 'package:bukeet/widgets/text/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeFieldOwnerFragment extends StatelessWidget {
  final HomeFieldOwnerFragmentController controller;

  const HomeFieldOwnerFragment({super.key, required this.controller});

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
          SafeArea(
            child: Container(
              width: AppSize.width(),
              height: AppSize.height(),
              margin: EdgeInsets.symmetric(
                vertical: AppMargin.vertical(),
                horizontal: AppMargin.horizontal(),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //_titleWidget(),
                  (controller.isLoadData.value)
                      ? _fieldsListWidget()
                      : LoadingDataWidget(),
                ],
              ),
            ),
          ),
          _floatingButtonWidget(),
        ],
      ),
    );
  }

  /*Widget _titleWidget() {
    return TextWidget(
      'Mis Canchas'.tr,
      fontFamily: AppFontFamily.leagueSpartan,
      fontWeight: TextWidgetWeight.bold,
    );
  }*/

  Widget _fieldsListWidget() {
    return Expanded(
      child: FadeIn(
        duration: const Duration(milliseconds: 1000),
        child: SizedBox(
          height: AppSize.height() * 0.7,
          child: ListView.builder(
            padding: EdgeInsets.only(bottom: AppMargin.vertical() * 2),
            scrollDirection: Axis.vertical,
            itemCount: controller.arenas.length,
            itemBuilder: (context, index) {
              var item = controller.arenas[index];
              return InkWell(
                onTap: () => controller.showFields(item),
                child: _fieldItemWidget(item),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _fieldItemWidget(Arena item) {
    return SizedBox(
      width: AppSize.width() * 0.8,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: SizedBox(
              height: AppSize.height() * 0.3,
              width: double.infinity,
              child: NetworkImageWidget(imageUrl: item.imageUrl ?? ''),
            ),
          ),
          SizedBox(
            width: AppSize.width() * 0.9,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextWidget(
                  '${item.name}',
                  fontFamily: AppFontFamily.leagueSpartan,
                  fontWeight: TextWidgetWeight.bold,
                  color: controller.theme.black.value,
                ),
                TextWidget(
                  '${item.address}',
                  fontFamily: AppFontFamily.leagueSpartan,
                  color: controller.theme.black.value,
                  height: 0.5,
                ),
              ],
            ),
          ),
          SizedBox(height: AppSize.width() * 0.1),
        ],
      ),
    );
  }

  Widget _floatingButtonWidget() {
    return (controller.isLoadData.value)
        ? Positioned(
            right: AppSize.width() * 0.06,
            bottom: AppSize.height() * 0.14,
            child: FadeIn(
              delay: const Duration(milliseconds: 600),
              duration: const Duration(milliseconds: 800),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconSolidButtonWidget(
                    fontFamily: AppFontFamily.workSans,
                    textSize: TextWidgetSizes.small,
                    color: controller.theme.greenMin.value,
                    disableColor: controller.theme.disable.value,
                    onPressed: () {
                      controller.createArena();
                    },
                    isActive: true,
                    height: AppSize.width() * 0.13,
                    width: AppSize.width() * 0.13,
                    iconRigth: AppIcons.add,
                    iconSize: 20,
                    iconColor: controller.theme.white.value,
                  ),
                  SizedBox(height: AppSize.height() * 0.01),
                ],
              ),
            ),
          )
        : const SizedBox();
  }
}
