import 'package:bukeet/flows/fieldOwner/fieldOwnerAdmin/controllers/field_owner_admin_flow.dart';
import 'package:bukeet/flows/fieldOwner/fieldOwnerAdmin/routes/field_admin_routes.dart';
import 'package:bukeet/modules/fieldOwner/fieldOwnerAdmin/controllers/list_field_admin_controller.dart';
import 'package:bukeet/modules/fieldOwner/fieldOwnerAdmin/pages/list_field_admin_page.dart';
import 'package:bukeet/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListFieldAdminPageFlow extends StatefulWidget {
  const ListFieldAdminPageFlow({super.key});

  @override
  State<ListFieldAdminPageFlow> createState() => _ListFieldAdminPageFlowState();
}

class _ListFieldAdminPageFlowState extends State<ListFieldAdminPageFlow> {
  late ListFieldAdminController _controller;
  final _fieldAdminFlow = Get.find<FieldOwnerAdminFlow>();
  final _theme = Get.find<AppTheme>();

  @override
  void initState() {
    super.initState();
    _controller = ListFieldAdminController(
      theme: _theme,
      arenaInformation: _fieldAdminFlow.getArena(),
      onNext: (field) async {
        _fieldAdminFlow.setField(field);
        FocusManager.instance.primaryFocus?.unfocus();
        await Future.delayed(const Duration(milliseconds: 300));
        Get.toNamed(FieldAdminRoutes().editFieldAdmin);
      },
    );

    _controller.startController();
  }

  @override
  Widget build(BuildContext context) {
    return ListFieldAdminPage(
      controller: _controller,
    );
  }
}
