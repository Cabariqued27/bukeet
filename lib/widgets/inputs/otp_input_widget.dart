import 'package:bukeet/theme/theme.dart';
import 'package:bukeet/widgets/text/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pinput/pinput.dart';

class OtpInputWidget extends StatelessWidget {
  final TextEditingController codeController;
  final Function onCompleteCode;
  final VoidCallback onChanged;
  final AppTheme theme;
  final bool hasInvalidCode;

  const OtpInputWidget({
    super.key,
    required this.onCompleteCode,
    required this.codeController,
    required this.onChanged,
    required this.theme,
    required this.hasInvalidCode,
  });

  @override
  Widget build(BuildContext context) {
    return _widgetContent();
  }

  Widget _widgetContent() {
    var errorColor = theme.redSolid.value;

    final defaultPinTheme = PinTheme(
      width: 55.0,
      height: 60.0,
      textStyle: onlyTextStyle(
        color: (hasInvalidCode) ? errorColor : theme.black.value,
        fontFamily: AppFontFamily.workSans,
        dsize: RelSize(size: TextWidgetSizes.buttonsTitle),
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: (hasInvalidCode) ? errorColor : theme.itemBorder.value,
          width: 1,
        ),
        color: theme.background.value,
        borderRadius: BorderRadius.circular(10.0),
      ),
    );

    final focusedPinTheme = PinTheme(
      width: 55.0,
      height: 60.0,
      textStyle: onlyTextStyle(
        color: (hasInvalidCode) ? errorColor : theme.black.value,
        fontFamily: AppFontFamily.workSans,
        dsize: RelSize(size: TextWidgetSizes.buttonsTitle),
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: (hasInvalidCode) ? errorColor : theme.primary.value,
          width: 1,
        ),
        color: theme.background.value,
        borderRadius: BorderRadius.circular(10.0),
      ),
    );

    return SizedBox(
      child: Pinput(
        length: 6,
        defaultPinTheme: defaultPinTheme,
        focusedPinTheme: focusedPinTheme,
        controller: codeController,
        onChanged: (value) => onChanged(),
        onCompleted: (pin) => onCompleteCode(),
        keyboardType: TextInputType.number,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      ),
    );
  }
}
