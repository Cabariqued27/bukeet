import 'package:bukeet/theme/theme.dart';
import 'package:bukeet/utils/app/app_size.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WebFrameWidget extends StatelessWidget {
  final Widget child;

  WebFrameWidget({
    super.key,
    required this.child,
  });

  final theme = Get.find<AppTheme>();
  final size = MediaQuery.of(Get.context!).size;

  @override
  Widget build(BuildContext context) {
    return _widgetContent();
  }

  Widget _widgetContent() {
    return Container(
      width: size.width,
      height: size.height,
      color: theme.background.value,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _bodyWidget(),
        ],
      ),
    );
  }

  Widget _bodyWidget() {
    return Container(
      width: AppSize.width(),
      height: AppSize.height(),
      decoration: BoxDecoration(
        color: theme.background.value,
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            color: theme.gray.value.withOpacity(0.4),
            spreadRadius: 4.0,
            blurRadius: 9.0,
            offset: const Offset(0, 0.5),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: child,
      ),
    );
  }
}
