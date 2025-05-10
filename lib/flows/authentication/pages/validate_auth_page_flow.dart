import 'package:bukeet/flows/admin/home/controllers/home_admin_flow.dart';
import 'package:bukeet/flows/authentication/routes/authentication_routes.dart';
import 'package:bukeet/flows/fieldOwner/home/controllers/home_field_owner_flow.dart';
import 'package:bukeet/flows/user/home/controllers/home_admin_flow.dart';
import 'package:bukeet/modules/authentication/controllers/validate_auth_controller.dart';
import 'package:bukeet/modules/authentication/pages/validate_auth_page.dart';
import 'package:bukeet/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ValidateAuthPageFlow extends StatefulWidget {
  const ValidateAuthPageFlow({super.key});

  @override
  State<ValidateAuthPageFlow> createState() => _ValidateAuthPageFlowState();
}

class _ValidateAuthPageFlowState extends State<ValidateAuthPageFlow> {
  late ValidateAuthController _controller;
  final _userHomeFlow = Get.find<HomeUserFlow>();
  final _adminHomeFlow = Get.find<HomeAdminFlow>();
  final _fieldOwnerHomeFlow = Get.find<HomeFieldOwnerFlow>();
  final _theme = Get.find<AppTheme>();

  @override
  void initState() {
    super.initState();
    _controller = ValidateAuthController(
      theme: _theme,
      onUserHome: () {
       _userHomeFlow.startOffNamed();
      },
      onAdminHome: () {
       _adminHomeFlow.startOffNamed();
      },
      onFieldOwnerHome: () async {
        _fieldOwnerHomeFlow.startOffNamed();
      },
      onAuth: () {
        Get.offAllNamed(AuthenticationRoutes().auth);
      },
    );

    _controller.startContoller();
  }

  @override
  Widget build(BuildContext context) {
    return ValidateAuthPage(
      controller: _controller,
    );
  }
}
