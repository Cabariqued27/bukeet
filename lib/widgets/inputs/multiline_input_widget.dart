import 'package:bukeet/theme/theme.dart';
import 'package:bukeet/widgets/text/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MultilineInputWidget extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final Function(String) onChanged;
  final String? Function(String?)? validator;
  final TextInputType textInputType;

  MultilineInputWidget({
    super.key,
    required this.hintText,
    required this.controller,
    required this.onChanged,
    this.validator,
    this.textInputType = TextInputType.multiline,
  });

  final _theme = Get.find<AppTheme>();
  @override
  Widget build(BuildContext context) {
    return _widgetContent();
  }

  Widget _widgetContent() {
    return SizedBox(
      width: double.infinity,
      height: 130.0,
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        keyboardType: textInputType,
        cursorColor: _theme.primary.value,
        minLines: 8,
        maxLines: 15,
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
            borderSide:  BorderSide(
              color: _theme.grayAccent.value,
              width: 1.0,
            ),
          ),
        ),
      ),
    );
  }
}
