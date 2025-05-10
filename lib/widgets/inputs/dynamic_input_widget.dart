import 'package:bukeet/assets/app_assets.dart';
import 'package:bukeet/theme/theme.dart';
import 'package:bukeet/widgets/svg/svg_asset_widget.dart';
import 'package:bukeet/widgets/text/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DynamicInputWidget extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final Function(String) onChanged;
  final String? Function(String?)? validator;
  final TextInputType textInputType;
  final bool isEditable;
  final bool? mandatory;

  DynamicInputWidget({
    super.key,
    required this.hintText,
    required this.controller,
    required this.onChanged,
    this.validator,
    this.textInputType = TextInputType.text,
    required this.isEditable,
    this.mandatory,
  });

  final _theme = Get.find<AppTheme>();
  @override
  Widget build(BuildContext context) {
    return _widgetContent();
  }

  Widget _widgetContent() {
    return SizedBox(
      width: double.infinity,
      height: 48.0,
      child: TextFormField(
        controller: controller,
        onChanged: isEditable ? onChanged : null,
        keyboardType: textInputType,
        cursorColor: _theme.primary.value,
        style: onlyTextStyle(
          color: _theme.black.value,
          fontFamily: AppFontFamily.workSans,
          dsize: RelSize(
            size: TextWidgetSizes.buttonsTitle,
          ),
        ),
        decoration: InputDecoration(
          errorText: null,
          errorStyle: onlyTextStyle(
            fontFamily: AppFontFamily.workSans,
            height: 0.0,
            dsize: RelSize(
              size: TextWidgetSizes.xxxxsmall,
            ),
          ),
          suffixIcon: Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: (mandatory ?? false)
                ? SvgAssetWidget(
                    color: _theme.primary.value,
                    path: AppIcons.mandatory,
                  )
                : const SizedBox(),
          ),
          suffixIconConstraints: const BoxConstraints(
            minWidth: 30.0,
            minHeight: 30.0,
          ),
          filled: true,
          fillColor: const Color.fromARGB(255, 255, 255, 255),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 10,
          ),
          hintText: hintText,
          hintStyle: onlyTextStyle(
            color: _theme.onText.value,
            fontFamily: AppFontFamily.workSans,
            dsize: RelSize(
              size: TextWidgetSizes.buttonsTitle,
            ),
          ).copyWith(
            fontStyle: FontStyle.italic,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(
              color: Color.fromARGB(255, 215, 215, 215),
              width: 1.0,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(
              color: _theme.grayAccent.value,
              width: 1.0,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Color.fromARGB(255, 221, 42, 78),
              width: 2.0,
            ),
          ),
        ),
        readOnly: !isEditable,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: validator,
      ),
    );
  }
}
