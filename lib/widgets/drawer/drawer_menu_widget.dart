import 'package:bukeet/assets/app_assets.dart';
import 'package:bukeet/preferences/user_preferences.dart';
import 'package:bukeet/settings/app_settings.dart';
import 'package:bukeet/utils/app/app_margin.dart';
import 'package:bukeet/utils/app/app_size.dart';
import 'package:bukeet/widgets/buttons/svg_icon_button_widget.dart';
import 'package:bukeet/widgets/drawer/controllers/drawer_menu_controller.dart';
import 'package:bukeet/widgets/svg/svg_asset_widget.dart';
import 'package:bukeet/widgets/text/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DrawerMenuWidget extends StatelessWidget {
  final VoidCallback onClose;
  final VoidCallback? onCallBack;

  DrawerMenuWidget({super.key, required this.onClose, this.onCallBack});

  final _preferences = UserPreferences();
  final DrawerMenuController controller = Get.put(DrawerMenuController());

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(canvasColor: Colors.transparent),
      child: Drawer(
        backgroundColor: const Color(0xffF4F4F4),
        elevation: 0.0,
        width: AppSize.width(),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0.0)),
        child: _widgetContent(),
      ),
    );
  }

  Widget _widgetContent() {
    return GetBuilder(
      init: DrawerMenuController(),
      builder: (DrawerMenuController controller) {
        return SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: SafeArea(
            child: Container(
              width: double.infinity,
              height: double.infinity,
              padding: EdgeInsets.symmetric(
                vertical: AppMargin.vertical(),
                horizontal: AppMargin.horizontal(),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _appBarWidget(controller),
                  const SizedBox(),
                  const SizedBox(),
                  _topbuttonsWidget(controller),
                  const SizedBox(),
                  _bottombuttonsWidget(controller),
                  const SizedBox(),
                  const SizedBox(),
                  const SizedBox(),
                  const SizedBox(),
                  _versionTextWidget(controller),
                  const SizedBox(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _textWidget(DrawerMenuController controller, String text) {
    return TextWidget(
      text.tr,
      fontFamily: AppFontFamily.leagueSpartan,
      fontWeight: TextWidgetWeight.bold,
      dsize: RelSize(size: TextWidgetSizes.semiLarge),
      color: controller.theme.black.value,
    );
  }

  Widget _appBarWidget(DrawerMenuController controller) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SvgIconButtonWidget(
          size: AppSize.width() * 0.07,
          icon: AppIcons.leftArrowSettings,
          onPressed: () => Get.back(),
          color: controller.theme.primary.value,
          alignment: Alignment.centerLeft,
        ),
        TextWidget(
          'configuration'.tr,
          fontFamily: AppFontFamily.leagueSpartan,
          fontWeight: TextWidgetWeight.bold,
          dsize: RelSize(size: TextWidgetSizes.semiLarge),
          color: controller.theme.black.value,
        ),
        SizedBox(width: AppSize.width() * 0.07),
      ],
    );
  }

  Widget _topbuttonsWidget(DrawerMenuController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _textWidget(controller, 'general'),
        Container(
          width: AppSize.width() * 0.9,
          decoration: BoxDecoration(
            color: controller.theme.whiteText.value,
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buttonWidget(
                title: 'personal_information'.tr,
                icon: AppIcons.profile,
                onPressed: () => controller.onEditProfile(onCallBack),
                controller: controller,
              ),
              Divider(
                color: controller.theme.backgroundDeviceSetting.value,
                thickness: 0.5,
              ),
              _buttonWidget(
                title: 'home'.tr,
                icon: AppIcons.menuHome,
                onPressed: () => controller.onHome(),
                controller: controller,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _bottombuttonsWidget(DrawerMenuController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _textWidget(controller, 'account_terms'),
        Container(
          width: AppSize.width() * 0.9,
          decoration: BoxDecoration(
            color: controller.theme.white.value,
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buttonWidget(
                title: 'privacy_policy'.tr,
                icon: AppIcons.privacy,
                onPressed: () => controller.onPrivacyPolicy(),
                controller: controller,
              ),
              Divider(
                color: controller.theme.backgroundDeviceSetting.value,
                thickness: 0.5,
              ),
              _buttonWidget(
                title: 'terms_conditions'.tr,
                icon: AppIcons.terms,
                onPressed: () => controller.onTermsConditions(),
                controller: controller,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buttonWidget({
    required String icon,
    required String title,
    required VoidCallback onPressed,
    required DrawerMenuController controller,
  }) {
    var size = AppSize.width() * 0.1;

    return InkWell(
      onTap: () => onPressed(),
      borderRadius: BorderRadius.circular(10.0),
      child: SizedBox(
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(width: AppSize.width() * 0.01),
            Container(
              width: size,
              height: size,
              padding: EdgeInsets.all(size * 0.25),
              child: SvgAssetWidget(
                path: icon,
                width: size,
                height: size,
                color: controller.theme.black.value,
              ),
            ),
            SizedBox(width: AppSize.width() * 0.01),
            TextWidget(
              title,
              fontFamily: AppFontFamily.leagueSpartan,
              color: controller.theme.black.value,
              textOverflow: TextOverflow.clip,
              fontWeight: TextWidgetWeight.bold,
              dsize: RelSize(size: TextWidgetSizes.buttonsTitle),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _versionTextWidget(DrawerMenuController controller) {
    return Column(
      children: [
        TextWidget(
          'you_signed'.tr,
          fontFamily: AppFontFamily.workSans,
          textAlign: TextAlign.center,
          fontWeight: TextWidgetWeight.normal,
          dsize: RelSize(size: TextWidgetSizes.xsmall),
          color: controller.theme.mustHaveColorText.value,
        ),
        TextWidget(
          _preferences.getEmail(),
          fontFamily: AppFontFamily.workSans,
          textAlign: TextAlign.center,
          fontWeight: TextWidgetWeight.normal,
          dsize: RelSize(size: TextWidgetSizes.xsmall),
          color: controller.theme.mustHaveColorText.value,
        ),
        SizedBox(height: AppSize.width() * 0.05),
        TextWidget(
          'software_version'.tr + AppSetting.appVersion,
          fontFamily: AppFontFamily.workSans,
          textAlign: TextAlign.center,
          fontWeight: TextWidgetWeight.normal,
          dsize: RelSize(size: TextWidgetSizes.xsmall),
          color: controller.theme.mustHaveColorText.value,
        ),
      ],
    );
  }
}
