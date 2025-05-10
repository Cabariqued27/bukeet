import 'package:bukeet/assets/app_assets.dart';
import 'package:bukeet/modules/fieldOwner/fieldOwnerAdmin/controllers/create_field_admin_controller.dart';
import 'package:bukeet/utils/app/app_margin.dart';
import 'package:bukeet/utils/app/app_size.dart';
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
                _titleWidget(),
                _capacityDropDownWidget(),
                _updateAvailabilityButton()
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
            border: Border.all(
              color: controller.theme.grayAccent.value,
            ),
          ),
          child: DropdownButton<int>(
            isExpanded: true,
            underline: const SizedBox(),
            focusColor: controller.theme.backgroundDeviceSetting.value,
            hint: _dropDownHint(),
            value: controller.fieldCapacities
                    .contains(controller.capacitySelected.value)
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

  Widget _updateAvailabilityButton() {
    return IconSolidButtonWidget(
      fontFamily: AppFontFamily.workSans,
      textSize: TextWidgetSizes.small,
      color: controller.theme.greenMin.value,
      disableColor: controller.theme.disable.value,
      onPressed: () {
        controller.createField();
      },
      isActive: controller.capacitySelected.value!=0,
      height: 55.0,
      width: AppSize.width() * 0.15,
      iconRigth: AppIcons.rightArrowPopUp,
      iconSize: 20,
      iconColor: controller.theme.gradientPair.value,
    );
  }
}
