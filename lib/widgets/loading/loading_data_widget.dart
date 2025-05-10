
import 'package:bukeet/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoadingDataWidget extends StatelessWidget {
  LoadingDataWidget({super.key});

  final _theme = Get.find<AppTheme>();

  @override
  Widget build(BuildContext context) {
    return _widgetContent();
  }

  Widget _widgetContent() {
    return Center(
      child: CircularProgressIndicator(
        color: _theme.primary.value,
      ),
    );
  }
}
