import 'package:bukeet/assets/app_assets.dart';
import 'package:bukeet/modules/fieldOwner/fieldOwnerAdmin/controllers/create_field_admin_controller.dart';
import 'package:bukeet/utils/app/app_margin.dart';
import 'package:bukeet/utils/app/app_size.dart';
import 'package:bukeet/utils/global/apply_opacity_util.dart';
import 'package:bukeet/utils/images/image_utils.dart';
import 'package:bukeet/widgets/buttons/icons_solid_button_widget.dart';
import 'package:bukeet/widgets/responsive/responsive_widget.dart';
import 'package:bukeet/widgets/responsive/web_frame_widget.dart';
import 'package:bukeet/widgets/text/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateFieldAdminPage extends StatelessWidget {
  final CreateFieldAdminController controller;

  const CreateFieldAdminPage({super.key, required this.controller});

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
              children: [
                const SizedBox(),
                _titleWidget(),
                const SizedBox(),
                _imagePickerWidget(),
                const SizedBox(),
                _capacityDropDownWidget(),
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
      controller.arenaInformation!.name.toString(),
      fontFamily: AppFontFamily.leagueSpartan,
      fontWeight: TextWidgetWeight.bold,
    );
  }

  Widget _capacityDropDownWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _textLabel('player_capacity'),
        Container(
          width: AppSize.width() * 0.9,
          height: AppSize.height() * 0.06,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: controller.theme.white.value,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: controller.theme.grayAccent.value),
          ),
          child: DropdownButton<int>(
            isExpanded: true,
            underline: const SizedBox(),
            focusColor: controller.theme.backgroundDeviceSetting.value,
            hint: _dropDownHint(),
            value:
                controller.fieldCapacities.contains(
                  controller.capacitySelected.value,
                )
                ? controller.capacitySelected.value
                : null,
            items: controller.fieldCapacities.map(_dropDownItem).toList(),
            onChanged: (value) {
              if (value != null) {
                controller.setSelectedFieldCapacity(value);
              }
            },
          ),
        ),
      ],
    );
  }

  TextWidget _dropDownHint() {
    return TextWidget(
      'select_field_capacity'.tr,
      fontFamily: AppFontFamily.workSans,
      fontStyle: FontStyle.italic,
      textAlign: TextAlign.center,
      dsize: RelSize(size: TextWidgetSizes.small),
      color: controller.theme.onText.value,
    );
  }

  DropdownMenuItem<int> _dropDownItem(int value) {
    return DropdownMenuItem<int>(
      value: value,
      child: TextWidget(
        '$value vs $value',
        fontFamily: AppFontFamily.workSans,
        textAlign: TextAlign.center,
        dsize: RelSize(size: TextWidgetSizes.small),
        color: controller.theme.gray.value,
      ),
    );
  }

  Widget _textLabel(String textKey) {
    return TextWidget(
      textKey.tr,
      fontFamily: AppFontFamily.workSans,
      textAlign: TextAlign.center,
      fontWeight: TextWidgetWeight.medium,
      dsize: RelSize(size: TextWidgetSizes.xsmall),
      color: controller.theme.black.value,
    );
  }

  Widget _imagePickerWidget() {
    final selected = controller.selectedFiles;
    final borderRadius = BorderRadius.circular(16);
    final isLimitReached = selected.length >= 3;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _textLabel('Imágenes del campo (máx. 3)'),
        const SizedBox(height: 10),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            ...selected.map(
              (xfile) => Stack(
                children: [
                  ClipRRect(
                    borderRadius: borderRadius,
                    child: Image.file(
                      ImageUtils.xFileToFile(xfile)!,
                      width: AppSize.width() * 0.25,
                      height: AppSize.width() * 0.25,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: 4,
                    right: 4,
                    child: GestureDetector(
                      onTap: () => controller.selectedFiles.remove(xfile),
                      child: Container(
                        decoration: BoxDecoration(
                          color: applyOpacity(Colors.black, 0.5),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.close,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (!isLimitReached)
              GestureDetector(
                onTap: controller.pickImages,
                child: Container(
                  width: AppSize.width() * 0.25,
                  height: AppSize.width() * 0.25,
                  decoration: BoxDecoration(
                    borderRadius: borderRadius,
                    color: controller.theme.backgroundDeviceSetting.value,
                    border: Border.all(
                      color: controller.theme.grayAccent.value,
                    ),
                  ),
                  child: const Center(child: Icon(Icons.add_a_photo, size: 30)),
                ),
              ),
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
      iconColor: controller.theme.white.value,
    );
  }
}
