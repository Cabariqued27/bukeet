import 'package:animate_do/animate_do.dart';
import 'package:bukeet/assets/app_assets.dart';
import 'package:bukeet/theme/theme.dart';
import 'package:bukeet/utils/app/app_margin.dart';
import 'package:bukeet/utils/app/app_size.dart';
import 'package:bukeet/utils/global/size_device_utils.dart';
import 'package:bukeet/widgets/gradient/gradient_widget.dart';
import 'package:bukeet/widgets/svg/svg_asset_widget.dart';
import 'package:bukeet/widgets/text/text_widget.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class HomeMenuWidget extends StatelessWidget {
  final AppTheme theme;
  final RxInt currentPage;
  final Function(int) onChangePage;
  final bool isOpenMenu;
  

  const HomeMenuWidget({
    Key? key,
    required this.onChangePage,
    required this.currentPage,
    required this.theme,
    required this.isOpenMenu,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _widgetContent();
  }

  Widget _widgetContent() {
    return AnimatedContainer(
      width: AppSize.width(),
      height: (isOpenMenu) ? AppSize.menuHeight() : 0.0,
      duration: const Duration(milliseconds: 500),
      padding: EdgeInsets.only(
        left: AppMargin.horizontal() * 0.5,
        right: AppMargin.horizontal() * 0.5,
        bottom: AppMargin.vertical() * 1.1,
      ),
      decoration: BoxDecoration(
        color: theme.background.value,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(40.0),
          topRight: Radius.circular(40.0),
        ),
        boxShadow: [
          BoxShadow(
            blurRadius: 6,
            offset: const Offset(0, 0),
            color: theme.grayAccent.value,
          ),
        ],
      ),
      child: (isOpenMenu)
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _iconButton(
                  iconPath: AppIcons.menuHome,
                  title: 'menu_home'.tr,
                  index: 0,
                  activate: AppIcons.menuHomeGradient,
                ),
                _iconButton(
                  iconPath: AppIcons.list,
                  title: 'menu_reservations'.tr,
                  index: 1,
                  activate: AppIcons.list,
                ),
                _iconButton(
                  iconPath: AppIcons.menuProfile,
                  title: 'menu_profile'.tr,
                  index: 2,
                  activate: AppIcons.menuProfileFill,
                ),
              ],
            )
          : const SizedBox(),
    );
  }

  Widget _iconButton({
    required String iconPath,
    required String title,
    required int index,
    required activate,
  }) {
    var size = AppSize.height();

    var buttonSize = (isDesktop) ? size * 0.08 : size * 0.07;

    return FadeIn(
      delay: const Duration(milliseconds: 500),
      child: SizedBox(
        height: buttonSize,
        child: GestureDetector(
          onTap: () => onChangePage(index),
          behavior: HitTestBehavior.opaque,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              (currentPage.value == index)
                  ? GradientWidget(
                      gradient: theme.refreshGradientMenu.value,
                      child: SvgAssetWidget(
                        color: theme.gray.value,
                        width: size * 0.025,
                        height: size * 0.025,
                        path: activate,
                      ),
                    )
                  : SvgAssetWidget(
                      color: theme.gray.value,
                      width: size * 0.025,
                      height: size * 0.025,
                      path: iconPath,
                    ),
              SizedBox(height: AppSize.height() * 0.01),
              (currentPage.value == index)
                  ? GradientWidget(
                      gradient: theme.refreshGradientMenu.value,
                      child: TextWidget(
                        title.tr,
                        fontFamily: AppFontFamily.workSans,
                        color: theme.gray.value,
                        dsize: RelSize(size: TextWidgetSizes.xxsmall),
                        fontWeight: TextWidgetWeight.bold,
                        textOverflow: TextOverflow.clip,
                      ),
                    )
                  : TextWidget(
                      title.tr,
                      fontFamily: AppFontFamily.workSans,
                      color: theme.gray.value,
                      dsize: RelSize(size: TextWidgetSizes.xxsmall),
                      fontWeight: TextWidgetWeight.normal,
                      textOverflow: TextOverflow.clip,
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
