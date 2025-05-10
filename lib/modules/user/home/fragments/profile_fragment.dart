import 'package:animate_do/animate_do.dart';
import 'package:bukeet/modules/user/home/controllers/profile_user_fragment_controller.dart';
import 'package:bukeet/utils/app/app_margin.dart';
import 'package:bukeet/utils/app/app_size.dart';
import 'package:bukeet/utils/buttons/gradient_button_widget.dart';
import 'package:bukeet/widgets/responsive/responsive_widget.dart';
import 'package:bukeet/widgets/responsive/web_frame_widget.dart';
import 'package:bukeet/widgets/text/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileUserFragment extends StatelessWidget {
  final ProfileUserFragmentController controller;

  const ProfileUserFragment({
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
                _userInformationWidget(),
                _logOutButtonWidget(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _userInformationWidget() {
    return FadeIn(
      duration: const Duration(milliseconds: 1000),
      child: Column(
        children: [
          TextWidget(
            '${controller.firstNameInputController.text} ${controller.lastNameInputController.text}',
            fontFamily: AppFontFamily.leagueSpartan,
            fontWeight: FontWeight.w600,
            dsize: RelSize(size: TextWidgetSizes.normal),
            color: controller.theme.black.value,
            textAlign: TextAlign.center,
          ),
          TextWidget(
            controller.date.value,
            fontFamily: AppFontFamily.leagueSpartan,
            fontWeight: FontWeight.w600,
            dsize: RelSize(size: TextWidgetSizes.normal),
            color: controller.theme.black.value,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _logOutButtonWidget() {
    return GradientButtonWidget(
      gradient: controller.theme.balancedGradient.value,
      disableColor: controller.theme.disable.value,
      textColor: controller.theme.text.value,
      onPressed: () async {
        //controller.onClick(ClickEventEnum.clickLogOut);
        await Future.delayed(const Duration(milliseconds: 200));
        controller.logOut();
      },
      isActive: true,
      title: 'logout'.tr,
      height: 50.0,
      width: double.infinity,
      fontFamily: AppFontFamily.workSans,
    );
  }
}
