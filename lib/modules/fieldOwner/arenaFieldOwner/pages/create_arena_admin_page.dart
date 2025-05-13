import 'package:bukeet/assets/app_assets.dart';
import 'package:bukeet/modules/fieldOwner/arenaFieldOwner/controllers/create_arena_admin_controller.dart';
import 'package:bukeet/utils/app/app_margin.dart';
import 'package:bukeet/utils/app/app_size.dart';
import 'package:bukeet/widgets/buttons/icons_solid_button_widget.dart';
import 'package:bukeet/widgets/inputs/single_input_widget.dart';
import 'package:bukeet/widgets/responsive/responsive_widget.dart';
import 'package:bukeet/widgets/responsive/web_frame_widget.dart';
import 'package:bukeet/widgets/text/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateArenaAdminPage extends StatelessWidget {
  final CreateArenaAdminController controller;

  const CreateArenaAdminPage({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final child = _mobileContent();
    return ResponsiveWidget(
      desktop: WebFrameWidget(child: child),
      tablet: WebFrameWidget(child: child),
      mobile: child,
    );
  }

  Widget _mobileContent() {
    return Obx(
      () => Scaffold(
        backgroundColor: controller.theme.background.value,
        body: SafeArea(
          child: Container(
            width: AppSize.width(),
            height: AppSize.height(),
            margin: EdgeInsets.symmetric(
              vertical: AppMargin.vertical(),
              horizontal: AppMargin.horizontal(),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [_titleWidget(), _inputsArenaWidget(),_updateAvailabilityButton()],
            ),
          ),
        ),
      ),
    );
  }

  Widget _titleWidget() {
    return TextWidget(
      'create_arena'.tr,
      fontFamily: AppFontFamily.leagueSpartan,
      fontWeight: TextWidgetWeight.bold,
    );
  }

  Widget _inputsArenaWidget() {
    return Column(
      children: [
        _arenaInputWidgetLogin(
            'arena_name','arena_city', controller.arenaNameInputController),
        _arenaInputWidgetLogin(
            'arena_address','arena_city', controller.arenaAddressInputController),
        _arenaInputWidgetLogin(
            'arena_city','arena_city', controller.arenaCityInputController),
      ],
    );
  }

  Widget _arenaInputWidgetLogin(
      String title,String hintText, TextEditingController controllerText) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextWidget(
          title.tr,
          fontFamily: AppFontFamily.workSans,
          textAlign: TextAlign.center,
          fontWeight: TextWidgetWeight.medium,
          dsize: RelSize(size: TextWidgetSizes.xsmall),
          color: controller.theme.black.value,
        ),
        SingleInputWidget(
          isActive: true,
          mandatory: false,
          hintText: hintText.tr,
          textInputType: TextInputType.emailAddress,
          controller: controllerText,
          onChanged: (value) => controller.onChangedLoginForm(),
        ),
      ],
    );
  }

  Widget _updateAvailabilityButton() {
    return IconSolidButtonWidget(
      fontFamily: AppFontFamily.workSans,
      textSize: TextWidgetSizes.small,
      color: controller.theme.greenMin.value,
      disableColor: controller.theme.disable.value,
      onPressed: () {
        controller.createField();
      },
      isActive: controller.activateNext.value,
      height: 55.0,
      width: AppSize.width() * 0.15,
      iconRigth: AppIcons.rightArrowPopUp,
      iconSize: 20,
      iconColor: controller.theme.greenMin.value,
    );
  }
}
