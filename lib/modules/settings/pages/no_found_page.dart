import 'package:bukeet/modules/settings/controllers/no_found_controller.dart';
import 'package:bukeet/widgets/responsive/responsive_widget.dart';
import 'package:bukeet/widgets/responsive/web_frame_widget.dart';
import 'package:bukeet/widgets/text/text_widget.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NoFoundPage extends StatelessWidget {
  final NoFoundController controller;

  const NoFoundPage({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      desktop: WebFrameWidget(
        child: _mobileContent(),
      ),
      tablet: WebFrameWidget(
        child: _mobileContent(),
      ),
      mobile: _mobileContent(),
    );
  }

  Widget _mobileContent() {
    return Scaffold(
      body: _pageWidget(),
      backgroundColor: controller.theme.background.value,
    );
  }

  Widget _pageWidget() {
    return Center(
      child: TextWidget(
        'No found page'.tr,
        fontFamily: AppFontFamily.workSans,
      ),
    );
  }
}
