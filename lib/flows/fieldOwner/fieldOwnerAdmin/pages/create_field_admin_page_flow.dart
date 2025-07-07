import 'package:bukeet/flows/fieldOwner/fieldOwnerAdmin/controllers/field_owner_admin_flow.dart';
import 'package:bukeet/flows/fieldOwner/home/controllers/home_field_owner_flow.dart';
import 'package:bukeet/modules/fieldOwner/fieldOwnerAdmin/controllers/create_field_admin_controller.dart';
import 'package:bukeet/modules/fieldOwner/fieldOwnerAdmin/pages/create_field_admin_page.dart';
import 'package:bukeet/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateFieldAdminPageFlow extends StatefulWidget {
  const CreateFieldAdminPageFlow({super.key});

  @override
  State<CreateFieldAdminPageFlow> createState() =>
      _CreateFieldAdminPageFlowState();
}

class _CreateFieldAdminPageFlowState extends State<CreateFieldAdminPageFlow> {
  late CreateFieldAdminController _controller;
  final _fieldOwnerAdminFlow = Get.find<FieldOwnerAdminFlow>();
  final _homeFieldOwnerFlow = Get.find<HomeFieldOwnerFlow>();
  final _theme = Get.find<AppTheme>();

  @override
  void initState() {
    super.initState();
    _controller = CreateFieldAdminController(
      theme: _theme,
      arenaInformation: _fieldOwnerAdminFlow.getArena(),
      onFinish: () async {
        await Future.delayed(const Duration(milliseconds: 300));
        _homeFieldOwnerFlow.start();
      },
    );

    _controller.startController();
  }

  @override
  Widget build(BuildContext context) {
    return CreateFieldAdminPage(controller: _controller);
  }
}
