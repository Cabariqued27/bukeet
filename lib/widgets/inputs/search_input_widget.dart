import 'package:bukeet/assets/app_assets.dart';
import 'package:bukeet/theme/theme.dart';
import 'package:bukeet/utils/app/app_size.dart';
import 'package:bukeet/widgets/svg/svg_asset_widget.dart';
import 'package:bukeet/widgets/text/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchInputWidget extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final Function(String) onChanged;
  final VoidCallback? onEditingComplete;
  final int? maxLength;
  final String? Function(String?)? validator;
  final TextInputType textInputType;

  SearchInputWidget({
    super.key,
    required this.hintText,
    required this.controller,
    required this.onChanged,
    this.validator,
    this.onEditingComplete,
    this.maxLength,
    this.textInputType = TextInputType.text,
  });

  final _theme = Get.find<AppTheme>();
  @override
  Widget build(BuildContext context) {
    return _widgetContent();
  }

  Widget _widgetContent() {
    return SizedBox(
      width: AppSize.width() * 0.9,
      height: AppSize.height() * 0.06,
      child: TextFormField(
        maxLength: maxLength,
        controller: controller,
        onChanged: onChanged,
        onEditingComplete: onEditingComplete,
        keyboardType: textInputType,
        cursorColor: _theme.primary.value,
        style: onlyTextStyle(
          color: _theme.black.value,
          fontFamily: AppFontFamily.leagueSpartan,
          dsize: RelSize(
            size: TextWidgetSizes.buttonsTitle,
          ),
        ),
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          counterText: "",
          suffixIcon: Padding(
              padding: const EdgeInsets.only(right: 15.0),
              child: SvgAssetWidget(
                color: _theme.gray.value,
                path: AppIcons.menuExplore,
              )),
          suffixIconConstraints: const BoxConstraints(
            minWidth: 30.0,
            minHeight: 30.0,
          ),
          errorText: null,
          errorStyle: onlyTextStyle(
            fontFamily: AppFontFamily.leagueSpartan,
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
            color: _theme.gray.value,
            fontFamily: AppFontFamily.leagueSpartan,
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
            borderRadius: BorderRadius.circular(30.0),
            borderSide: BorderSide(
              color: _theme.gray.value,
              width: 1.0,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: BorderSide(
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
