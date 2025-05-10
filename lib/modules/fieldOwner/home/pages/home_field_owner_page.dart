import 'dart:async';
import 'package:bukeet/modules/fieldOwner/home/controllers/home_field_owner_controller.dart';
import 'package:bukeet/modules/fieldOwner/home/controllers/home_field_owner_fragment_controller.dart';
import 'package:bukeet/modules/fieldOwner/home/controllers/profile_field_owner_fragment_controller.dart';
import 'package:bukeet/modules/fieldOwner/home/controllers/reservations_field_owner_fragment_controller.dart';
import 'package:bukeet/modules/fieldOwner/home/fragments/home_field_owner_fragment.dart';
import 'package:bukeet/modules/fieldOwner/home/fragments/profile_field_owner_fragment.dart';
import 'package:bukeet/modules/fieldOwner/home/fragments/reservations_field_owner_fragment.dart';
import 'package:bukeet/widgets/drawer/drawer_menu_widget.dart';
import 'package:bukeet/widgets/menu/home_menu_widget.dart';
import 'package:bukeet/widgets/responsive/responsive_widget.dart';
import 'package:bukeet/widgets/responsive/web_frame_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';

class HomeFieldOwnerPage extends StatefulWidget {
  final HomeFieldOwnerController controller;

  const HomeFieldOwnerPage({
    super.key,
    required this.controller,
  });

  @override
  State<HomeFieldOwnerPage> createState() => _HomeFieldOwnerPageState();
}

class _HomeFieldOwnerPageState extends State<HomeFieldOwnerPage> {
  late HomeFieldOwnerFragmentController homeFragmentController;
  late ReservationsFieldOwnerFragmentController reservationsFragmentController;
  late ProfileFieldOwnerFragmentController profileFragmentController;

  late StreamSubscription<bool> keyboardSubscription;

  @override
  void initState() {
    super.initState();
    startKeyBoardListener();
    startFragmentControllers();
  }

  void startFragmentControllers() async {
    homeFragmentController =
        HomeFieldOwnerFragmentController(theme: widget.controller.theme);
    reservationsFragmentController =
        ReservationsFieldOwnerFragmentController(theme: widget.controller.theme);
    profileFragmentController =
        ProfileFieldOwnerFragmentController(theme: widget.controller.theme);

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
        HomeFieldOwnerFragment(
          controller: homeFragmentController,
        ),
        ReservationsFieldOwnerFragment(
          controller: reservationsFragmentController,
        ),
        ProfileFieldOwnerFragment(
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
