import 'package:bukeet/flows/user/arena/controllers/arena_user_flow.dart';
import 'package:bukeet/flows/user/home/controllers/home_admin_flow.dart';
import 'package:bukeet/modules/user/arena/controllers/booking_controller.dart';
import 'package:bukeet/modules/user/arena/pages/booking_page.dart';
import 'package:bukeet/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookingPageFlow extends StatefulWidget {
  const BookingPageFlow({super.key});

  @override
  State<BookingPageFlow> createState() => _BookingPageFlowState();
}

class _BookingPageFlowState extends State<BookingPageFlow> {
  late BookingController _controller;
  final _arenaUserFlow = Get.find<ArenaUserFlow>();
  final _homeUserFlow = Get.find<HomeUserFlow>();

  final _theme = Get.find<AppTheme>();

  @override
  void initState() {
    super.initState();
    _controller = BookingController(
      theme: _theme,
      fieldInformation: _arenaUserFlow.getField(),
      arenaInformation: _arenaUserFlow.getArena(),
      onNext: () {
        _homeUserFlow.start();
      },
      onBack: () {
        _arenaUserFlow.deleteAllData();
        Get.back();
      },
    );

    _controller.startController();
  }

  @override
  Widget build(BuildContext context) {
    return BookingPage(
      controller: _controller,
    );
  }
}
