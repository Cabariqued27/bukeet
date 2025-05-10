import 'package:bukeet/flows/user/home/controllers/home_admin_flow.dart';
import 'package:bukeet/modules/user/home/controllers/home_user_controller.dart';
import 'package:bukeet/modules/user/home/pages/home_page.dart';
import 'package:bukeet/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePageFlow extends StatefulWidget {
  const HomePageFlow({super.key});

  @override
  State<HomePageFlow> createState() => _HomePageFlowState();
}

class _HomePageFlowState extends State<HomePageFlow> {
  late HomeUserController _controller;
  final _theme = Get.find<AppTheme>();
  final _homeUserFlow = Get.find<HomeUserFlow>();

  @override
  void initState() {
    super.initState();
    _controller = HomeUserController(
      theme: _theme,
      initialPage: _homeUserFlow.getInitialPage(),
      //onClick: (value) => AppClickEvents().onDetectEvent(value),
    );

    _controller.startController();
  }

  @override
  Widget build(BuildContext context) {
    return HomeUserPage(
      controller: _controller,
    );
  }
}
