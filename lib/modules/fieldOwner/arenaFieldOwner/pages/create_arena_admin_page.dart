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
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _titleWidget(),
                  _inputsArenaWidget(),
                  _imagePickerWidget(),
                  _updateAvailabilityButton(),
                ],
              ),
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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextWidget(
          'Imagen de la arena',
          fontFamily: AppFontFamily.workSans,
          dsize: RelSize(size: TextWidgetSizes.small),
          color: controller.theme.black.value,
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            IconButton(
              icon: const Icon(Icons.image, size: 30),
              onPressed: controller.pickImage,
            ),
            (file != null)
                ? Image.file(file, width: 100, height: 100, fit: BoxFit.cover)
                : const Text('No se ha seleccionado imagen'),
          ],
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
