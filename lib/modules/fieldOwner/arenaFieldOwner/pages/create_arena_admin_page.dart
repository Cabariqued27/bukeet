import 'package:bukeet/assets/app_assets.dart';
import 'package:bukeet/modules/fieldOwner/arenaFieldOwner/controllers/create_arena_admin_controller.dart';
import 'package:bukeet/utils/app/app_margin.dart';
import 'package:bukeet/utils/app/app_size.dart';
import 'package:bukeet/utils/global/apply_opacity_util.dart';
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _titleWidget(),
                const SizedBox(),
                _inputsArenaWidget(),
                const SizedBox(),
                _imagePickerWidget(),
                const SizedBox(),
                _updateAvailabilityButton(),
                const SizedBox(),
                const SizedBox(),
                const SizedBox(),
              ],
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
          'arena_name',
          'place_holder_arena_name',
          controller.arenaNameInputController,
        ),
        _arenaInputWidgetLogin(
          'arena_address',
          'place_holder_arena_address',
          controller.arenaAddressInputController,
        ),
        _arenaInputWidgetLogin(
          'arena_city',
          'place_holder_arena_city',
          controller.arenaCityInputController,
        ),
      ],
    );
  }

  Widget _arenaInputWidgetLogin(
    String title,
    String hintText,
    TextEditingController controllerText,
  ) {
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
          textInputType: TextInputType.text,
          controller: controllerText,
          onChanged: (value) => controller.onChangedLoginForm(),
        ),
      ],
    );
  }

  Widget _imagePickerWidget() {
    final file = controller.selectedImage.value;
    final borderRadius = BorderRadius.circular(16);
    final boxDecoration = BoxDecoration(
      color: controller.theme.backgroundDeviceSetting.value,
      borderRadius: borderRadius,
      border: Border.all(color: controller.theme.backgroundDeviceSetting.value),
      boxShadow: [
        BoxShadow(
          color: applyOpacity(controller.theme.black.value, 0.2),
          blurRadius: 6,
          offset: const Offset(0, 3),
        ),
      ],
    );

    return Container(
      decoration: boxDecoration,
      height: AppSize.width() * 0.3,
      width: AppSize.width() * 0.3,
      child: file != null
          ? ClipRRect(
              borderRadius: borderRadius,
              child: Image.file(
                file,
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
              ),
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.image, size: 30),
                  onPressed: controller.pickImage,
                ),
                TextWidget(
                  'Seleccionar imagen',
                  fontFamily: AppFontFamily.workSans,
                  dsize: RelSize(size: TextWidgetSizes.msmall),
                  color: controller.theme.black.value,
                ),
              ],
            ),
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
      iconColor: controller.theme.white.value,
    );
  }
}
