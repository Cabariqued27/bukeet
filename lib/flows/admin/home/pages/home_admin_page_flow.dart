import 'package:bukeet/flows/admin/home/controllers/home_admin_flow.dart';
import 'package:bukeet/modules/admin/home/controllers/home_admin_controller.dart';
import 'package:bukeet/modules/admin/home/pages/home_admin_page.dart';
import 'package:bukeet/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeAdminPageFlow extends StatefulWidget {
  const HomeAdminPageFlow({super.key});

  @override
  State<HomeAdminPageFlow> createState() => _HomeAdminPageFlowState();
}

class _HomeAdminPageFlowState extends State<HomeAdminPageFlow> {
  late HomeAdminController _controller;
  final _theme = Get.find<AppTheme>();
  final _homeAdminFlow = Get.find<HomeAdminFlow>();

  @override
  void initState() {
    super.initState();
    _controller = HomeAdminController(
      theme: _theme,
      initialPage: _homeAdminFlow.getInitialPage(),
      //onClick: (value) => AppClickEvents().onDetectEvent(value),
    );

    _controller.startController();
  }

  @override
  Widget build(BuildContext context) {
    return HomeAdminPage(
      controller: _controller,
    );
  }
}
