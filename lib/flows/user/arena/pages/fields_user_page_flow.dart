import 'package:bukeet/flows/user/arena/controllers/arena_user_flow.dart';
import 'package:bukeet/flows/user/arena/routes/arena_user_routes.dart';
import 'package:bukeet/modules/user/arena/controllers/fields_user_controller.dart';
import 'package:bukeet/modules/user/arena/pages/fields_user_page.dart';
import 'package:bukeet/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FieldsPageFlow extends StatefulWidget {
  const FieldsPageFlow({super.key});

  @override
  State<FieldsPageFlow> createState() => _FieldsPageFlowState();
}

class _FieldsPageFlowState extends State<FieldsPageFlow> {
  late FieldsUserController _controller;
  final _arenaUserFlow = Get.find<ArenaUserFlow>();
  final _theme = Get.find<AppTheme>();

  @override
  void initState() {
    super.initState();
    _controller = FieldsUserController(
      theme: _theme,
      arenaInformation: _arenaUserFlow.getArena(),
      onBack: () {
        _arenaUserFlow.deleteAllData();
        Get.back();
      },
      onNext: (field) async {
        _arenaUserFlow.setField(field);
        FocusManager.instance.primaryFocus?.unfocus();
        await Future.delayed(const Duration(milliseconds: 300));
        Get.toNamed(ArenaUserRoutes().booking);
      },
    );

    _controller.startController();
  }

  @override
  Widget build(BuildContext context) {
    return FieldsUserPage(
      controller: _controller,
    );
  }
}
