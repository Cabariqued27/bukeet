import 'package:bukeet/flows/admin/home/controllers/home_admin_flow.dart';
import 'package:bukeet/flows/fieldOwner/home/controllers/home_field_owner_flow.dart';
import 'package:bukeet/flows/user/home/controllers/home_admin_flow.dart';
import 'package:bukeet/modules/authentication/controllers/authentication_controller.dart';
import 'package:bukeet/modules/authentication/pages/authentication_page.dart';
import 'package:bukeet/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthenticationPageFlow extends StatefulWidget {
  const AuthenticationPageFlow({super.key});

  @override
  State<AuthenticationPageFlow> createState() => _AuthenticationPageFlowState();
}

class _AuthenticationPageFlowState extends State<AuthenticationPageFlow> {
  late AuthenticationController _controller;

  final _homeUserFlow = Get.find<HomeUserFlow>();
  final _homeAdminFlow = Get.find<HomeAdminFlow>();
  final _homeFieldOwnerFlow = Get.find<HomeFieldOwnerFlow>();
  final _theme = Get.find<AppTheme>();

  @override
  void initState() {
    super.initState();
    _controller = AuthenticationController(
      theme: _theme,
      onUserHome: () async {
        FocusManager.instance.primaryFocus?.unfocus();
        await Future.delayed(const Duration(milliseconds: 300));

        _homeUserFlow.start();
      },
      onAdminHome: () async {
        FocusManager.instance.primaryFocus?.unfocus();
        await Future.delayed(const Duration(milliseconds: 300));

        _homeAdminFlow.start();
      },
      onFieldOwnerHome: () async {
        FocusManager.instance.primaryFocus?.unfocus();
        await Future.delayed(const Duration(milliseconds: 300));

        _homeFieldOwnerFlow.start();
      },
      
    );
  }

  @override
  Widget build(BuildContext context) {
    return AuthenticationPage(
      controller: _controller,
    );
  }
}
