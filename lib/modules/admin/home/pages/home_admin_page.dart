import 'dart:async';
import 'package:bukeet/modules/admin/home/controllers/home_admin_controller.dart';
import 'package:bukeet/modules/admin/home/controllers/home_admin_fragment_controller.dart';
import 'package:bukeet/modules/admin/home/controllers/profile_admin_fragment_controller.dart';
import 'package:bukeet/modules/admin/home/controllers/reservations_admin_fragment_controller.dart';
import 'package:bukeet/modules/admin/home/fragments/home_admin_fragment.dart';
import 'package:bukeet/modules/admin/home/fragments/profile_admin_fragment.dart';
import 'package:bukeet/modules/admin/home/fragments/reservations_admin_fragment.dart';
import 'package:bukeet/widgets/drawer/drawer_menu_widget.dart';
import 'package:bukeet/widgets/menu/home_menu_widget.dart';
import 'package:bukeet/widgets/responsive/responsive_widget.dart';
import 'package:bukeet/widgets/responsive/web_frame_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';

class HomeAdminPage extends StatefulWidget {
  final HomeAdminController controller;

  const HomeAdminPage({
    super.key,
    required this.controller,
  });

  @override
  State<HomeAdminPage> createState() => _HomeAdminPageState();
}

class _HomeAdminPageState extends State<HomeAdminPage> {
  late HomeAdminFragmentController homeFragmentController;
  late ReservationsAdminFragmentController reservationsFragmentController;
  late ProfileAdminFragmentController profileFragmentController;

  late StreamSubscription<bool> keyboardSubscription;

  @override
  void initState() {
    super.initState();
    startKeyBoardListener();
    startFragmentControllers();
  }

  void startFragmentControllers() async {
    homeFragmentController =
        HomeAdminFragmentController(theme: widget.controller.theme);
    reservationsFragmentController =
        ReservationsAdminFragmentController(theme: widget.controller.theme);
    profileFragmentController =
        ProfileAdminFragmentController(theme: widget.controller.theme);

    homeFragmentController.startController();
    reservationsFragmentController.startController();
    profileFragmentController.startController();
  }

  void startKeyBoardListener() {
    var keyboardVisibilityController = KeyboardVisibilityController();
    keyboardSubscription =
        keyboardVisibilityController.onChange.listen((bool visible) {
      widget.controller.updateOpenMenu(!visible);
    });
  }

  @override
  void dispose() {
    keyboardSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      desktop: WebFrameWidget(
        child: _mobileContent(),
      ),
      tablet: WebFrameWidget(
        child: _mobileContent(),
      ),
      mobile: _mobileContent(),
    );
  }

  Widget _mobileContent() {
    return Obx(
      () => Scaffold(
        key: widget.controller.scaffoldKey,
        endDrawer: widget.controller.currentPage.value == 2
            ? DrawerMenuWidget(
                onClose: () => widget.controller.doCloseDrawer(),
                onCallBack: () => profileFragmentController.startController(),
              )
            : null,
        body: Stack(
          children: [
            _widgetPagesStack(),
            _menuWidget(),
          ],
        ),
      ),
    );
  }

  Widget _widgetPagesStack() {
    return IndexedStack(
      index: widget.controller.currentPage.value,
      children: [
        HomeAdminFragment(
          controller: homeFragmentController,
        ),
        ReservationsAdminFragment(
          controller: reservationsFragmentController,
        ),
        ProfileAdminFragment(
          controller: profileFragmentController,
        ),
      ],
    );
  }

  Widget _menuWidget() {
    return Positioned.fill(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: HomeMenuWidget(
          theme: widget.controller.theme,
          currentPage: widget.controller.currentPage,
          isOpenMenu: widget.controller.isOpenMenu.value,
          onChangePage: (value) => widget.controller.changePage(value: value),
        ),
      ),
    );
  }
}
