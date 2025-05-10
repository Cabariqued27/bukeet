import 'package:bukeet/modules/authentication/controllers/reset_password_controller.dart';
import 'package:bukeet/modules/authentication/pages/reset_password_page.dart';
import 'package:bukeet/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResetPasswordPageFlow extends StatefulWidget {
  const ResetPasswordPageFlow({super.key});

  @override
  State<ResetPasswordPageFlow> createState() => _ResetPasswordPageFlowState();
}

class _ResetPasswordPageFlowState extends State<ResetPasswordPageFlow> {
  late ResetPasswordController _controller;
  //final _homeFlow = Get.find<HomeFlow>();
  final _theme = Get.find<AppTheme>();

  @override
  void initState() {
    super.initState();
    _controller = ResetPasswordController(
      theme: _theme,
      onHome: () async {
        FocusManager.instance.primaryFocus?.unfocus();
        await Future.delayed(const Duration(milliseconds: 300));
        //_homeFlow.start();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ResetPasswordPage(
      controller: _controller,
    );
  }
}
