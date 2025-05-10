import 'package:bukeet/flows/fieldOwner/home/controllers/home_field_owner_flow.dart';
import 'package:bukeet/modules/fieldOwner/home/controllers/home_field_owner_controller.dart';
import 'package:bukeet/modules/fieldOwner/home/pages/home_field_owner_page.dart';
import 'package:bukeet/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeFieldOwnerPageFlow extends StatefulWidget {
  const HomeFieldOwnerPageFlow({super.key});

  @override
  State<HomeFieldOwnerPageFlow> createState() => _HomeFieldOwnerPageFlowState();
}

class _HomeFieldOwnerPageFlowState extends State<HomeFieldOwnerPageFlow> {
  late HomeFieldOwnerController _controller;
  final _theme = Get.find<AppTheme>();
  final _homeFieldOwnerFlow = Get.find<HomeFieldOwnerFlow>();

  @override
  void initState() {
    super.initState();
    _controller = HomeFieldOwnerController(
      theme: _theme,
      initialPage: _homeFieldOwnerFlow.getInitialPage(),
      //onClick: (value) => AppClickEvents().onDetectEvent(value),
    );

    _controller.startController();
  }

  @override
  Widget build(BuildContext context) {
    return HomeFieldOwnerPage(
      controller: _controller,
    );
  }
}
