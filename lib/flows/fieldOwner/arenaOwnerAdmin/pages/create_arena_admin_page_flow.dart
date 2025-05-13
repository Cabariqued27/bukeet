import 'package:bukeet/flows/fieldOwner/fieldOwnerAdmin/controllers/field_owner_admin_flow.dart';
import 'package:bukeet/flows/fieldOwner/fieldOwnerAdmin/routes/field_admin_routes.dart';
import 'package:bukeet/modules/fieldOwner/arenaFieldOwner/controllers/create_arena_admin_controller.dart';
import 'package:bukeet/modules/fieldOwner/arenaFieldOwner/pages/create_arena_admin_page.dart';
import 'package:bukeet/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateArenaAdminPageFlow extends StatefulWidget {
  const CreateArenaAdminPageFlow({super.key});

  @override
  State<CreateArenaAdminPageFlow> createState() => _CreateArenaAdminPageFlowState();
}

class _CreateArenaAdminPageFlowState extends State<CreateArenaAdminPageFlow> {
  late CreateArenaAdminController _controller;
  final _fieldOwnerAdminFlow = Get.find<FieldOwnerAdminFlow>();
  final _theme = Get.find<AppTheme>();

  @override
  void initState() {
    super.initState();
    _controller = CreateArenaAdminController(
      theme: _theme,
      arenaInformation: _fieldOwnerAdminFlow.getArena(),
      onFinish: () async {
      
        await Future.delayed(const Duration(milliseconds: 300));
        Get.offNamed(FieldAdminRoutes().listFieldAdmin);
      },
    );

    _controller.startController();
  }

  @override
  Widget build(BuildContext context) {
    return CreateArenaAdminPage(
      controller: _controller,
    );
  }
}
