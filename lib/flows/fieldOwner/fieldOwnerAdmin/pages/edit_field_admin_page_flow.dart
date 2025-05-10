import 'package:bukeet/flows/fieldOwner/fieldOwnerAdmin/controllers/field_owner_admin_flow.dart';
import 'package:bukeet/modules/fieldOwner/fieldOwnerAdmin/controllers/edit_field_admin_controller.dart';
import 'package:bukeet/modules/fieldOwner/fieldOwnerAdmin/pages/edit_field_admin_page.dart';
import 'package:bukeet/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditFieldAdminPageFlow extends StatefulWidget {
  const EditFieldAdminPageFlow({super.key});

  @override
  State<EditFieldAdminPageFlow> createState() => _EditFieldAdminPageFlowState();
}

class _EditFieldAdminPageFlowState extends State<EditFieldAdminPageFlow> {
  late EditFieldAdminController _controller;
  final _fieldOwnerAdminFlow = Get.find<FieldOwnerAdminFlow>();
  final _theme = Get.find<AppTheme>();

  @override
  void initState() {
    super.initState();
    _controller = EditFieldAdminController(
      theme: _theme,
      fieldInformation: _fieldOwnerAdminFlow.getField(),
      arenaInformation: _fieldOwnerAdminFlow.getArena(),
    );

    _controller.startController();
  }

  @override
  Widget build(BuildContext context) {
    return EditFieldAdminPage(
      controller: _controller,
    );
  }
}
