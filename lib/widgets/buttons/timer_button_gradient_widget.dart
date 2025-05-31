import 'package:bukeet/utils/colors/gradient_opacity_utils.dart';
import 'package:bukeet/utils/global/apply_opacity_util.dart';
import 'package:bukeet/widgets/text/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';

class TimerGradientButtonWidget extends StatelessWidget {
  final String title;
  final bool isActive;
  final Color textColor;
  final Color disableColor;
  final VoidCallback onPressed;
  final VoidCallback onEndTime;
  final LinearGradient gradient;
  final double height;
  final double width;
  final FontWeight? fontWeight;
  final double? textSize;
  final String fontFamily;
  final int endTime;

  const TimerGradientButtonWidget({
    super.key,
    required this.title,
    required this.isActive,
    required this.onPressed,
    required this.textColor,
    required this.gradient,
    required this.disableColor,
    required this.fontFamily,
    required this.onEndTime,
    required this.endTime,
    this.height = 0.0,
    this.width = 0.0,
    this.fontWeight,
    this.textSize,
  });

  @override
  Widget build(BuildContext context) {
    return _widgetContent();
  }

  Widget _widgetContent() {
    var enableGradient = gradient;
    var disableGradient = copyGradientWithOpacity(gradient, 0.5);

    return Container(
      width: width,
      height: height,
      margin: const EdgeInsets.all(0.0),
      padding: const EdgeInsets.all(0.0),
      decoration: BoxDecoration(
        gradient: (isActive) ? enableGradient : disableGradient,
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 0.0,
          padding: const EdgeInsets.all(0.0),
          backgroundColor: Colors.transparent,
          disabledForegroundColor: Colors.transparent,
          disabledBackgroundColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
        ),
        onPressed: (isActive) ? () => onPressed() : null,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _titleTextWidget(),
            _counterTextWidget(),
          ],
        ),
      ),
    );
  }

  Widget _titleTextWidget() {
    var enableTextColor = textColor;
    var disableTextColor = applyOpacity(textColor, 0.5);

    return TextWidget(
      title,
      fontFamily: fontFamily,
      textAlign: TextAlign.center,
      dsize: RelSize(
        size: textSize ?? TextWidgetSizes.normal,
      ),
      color: (isActive) ? enableTextColor : disableTextColor,
      fontWeight: fontWeight ?? TextWidgetWeight.medium,
    );
  }

  Widget _counterTextWidget() {
    var enableTextColor = textColor;
    var disableTextColor = applyOpacity(textColor, 0.5);

    return CountdownTimer(
      endTime: endTime,
      onEnd: () => onEndTime(),
      widgetBuilder: (_, CurrentRemainingTime? time) {
        if (time == null || isActive) {
          return TextWidget(
            ' 00:00',
            fontFamily: fontFamily,
            textAlign: TextAlign.center,
            dsize: RelSize(
              size: textSize ?? TextWidgetSizes.normal,
            ),
            color: (isActive) ? enableTextColor : disableTextColor,
            fontWeight: fontWeight ?? TextWidgetWeight.medium,
          );
        }

        var minutes = (time.min ?? 0).toString().padLeft(2, '0');
        var seconds = (time.sec ?? 0).toString().padLeft(2, '0');

        return TextWidget(
          ' $minutes:$seconds',
          fontFamily: fontFamily,
          textAlign: TextAlign.center,
          dsize: RelSize(
            size: textSize ?? TextWidgetSizes.normal,
          ),
          color: (isActive) ? enableTextColor : disableTextColor,
          fontWeight: fontWeight ?? TextWidgetWeight.medium,
        );
      },
    );
  }
}
