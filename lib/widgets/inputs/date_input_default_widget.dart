import 'package:bukeet/assets/app_assets.dart';
import 'package:bukeet/theme/theme.dart';
import 'package:bukeet/utils/app/app_size.dart';
import 'package:bukeet/widgets/svg/svg_asset_widget.dart';
import 'package:bukeet/widgets/text/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';  

class DateInputDefaultWidget extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final Function(String) onChanged;
  final String? Function(String?)? validator;
  final TextInputType textInputType;
  final DateTime defaultDate;

  DateInputDefaultWidget({
    super.key,
    required this.hintText,
    required this.controller,
    required this.onChanged,
    required this.defaultDate,
    this.validator,
    this.textInputType = TextInputType.datetime,
  });

  final _theme = Get.find<AppTheme>();

  @override
  Widget build(BuildContext context) {
   
    controller.text = DateFormat('dd/MM/yyyy').format(defaultDate);

    return _widgetContent();
  }

  Widget _widgetContent() {
    return SizedBox(
      width: AppSize.width() * 0.9,
      height: AppSize.height() * 0.06,
      child: TextFormField(
        enabled: false,
        controller: controller,
        onChanged: onChanged,
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
          suffixIcon: Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: SvgAssetWidget(
              color: _theme.datePickerIconColor.value,
              path: AppIcons.datePicker,
            ),
          ),
          suffixIconConstraints: const BoxConstraints(
            minWidth: 30.0,
            minHeight: 30.0,
          ),
          errorText: null,
          errorStyle: onlyTextStyle(
            fontFamily: AppFontFamily.workSans,
            height: 0.0,
            dsize: RelSize(
              size: TextWidgetSizes.xxxxsmall,
            ),
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
            borderRadius: BorderRadius.circular(15.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: const BorderSide(
              color: Color.fromARGB(255, 215, 215, 215),
              width: 1.0,
            ),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide:  BorderSide(
              color: _theme.grayAccent.value,
              width: 1.0,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide:  BorderSide(
              color: _theme.grayAccent.value,
              width: 1.0,
            ),
          ),
        ),
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: validator,
      ),
    );
  }
}
