import 'package:bukeet/assets/app_assets.dart';
import 'package:bukeet/modules/authentication/controllers/validate_auth_controller.dart';
import 'package:bukeet/utils/app/app_margin.dart';
import 'package:bukeet/utils/app/app_size.dart';
import 'package:bukeet/widgets/images/asset_image_widget.dart';
import 'package:bukeet/widgets/responsive/responsive_widget.dart';
import 'package:bukeet/widgets/responsive/web_frame_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ValidateAuthPage extends StatelessWidget {
  final ValidateAuthController controller;

  const ValidateAuthPage({
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
          AssetImageWidget(
            pathImage: AppImages.started,
            width: AppSize.width(),
            height: AppSize.height(),
          ),
          AssetImageWidget(
            pathImage: AppImages.splash,
            width: AppSize.width(),
            height: AppSize.height(),
          ),
          Container(
            width: AppSize.width(),
            height: AppSize.height(),
            margin: EdgeInsets.symmetric(
              vertical: AppMargin.vertical(),
              horizontal: AppMargin.horizontal(),
            ),
            child:  const Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(),
                //_logoWidget(),
                SizedBox(),
                SizedBox(),
                SizedBox(),
                SizedBox(),
                SizedBox(),
                SizedBox(),
                SizedBox(),
                SizedBox(),
                SizedBox(),
                SizedBox(),
              ],
            ),
          ),
        ],
      ),
    );
  }


  /*Widget _backgroundImageWidget() {
    return AssetImageWidget(
      pathImage: AppImages.splash,
      width: AppSize.width(),
      height: AppSize.height(),
    );
  }*/
}
