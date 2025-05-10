import 'package:animate_do/animate_do.dart';
import 'package:bukeet/modules/user/arena/controllers/fields_user_controller.dart';
import 'package:bukeet/services/models/field.dart';
import 'package:bukeet/utils/app/app_margin.dart';
import 'package:bukeet/utils/app/app_size.dart';
import 'package:bukeet/widgets/images/slider_network_image_widget.dart';
import 'package:bukeet/widgets/loading/loading_data_widget.dart';
import 'package:bukeet/widgets/responsive/responsive_widget.dart';
import 'package:bukeet/widgets/responsive/web_frame_widget.dart';
import 'package:bukeet/widgets/text/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FieldsUserPage extends StatelessWidget {
  final FieldsUserController controller;

  const FieldsUserPage({
    super.key,
    required this.controller,
  });

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
        body: _pageWidget(),
        backgroundColor: controller.theme.background.value,
      ),
    );
  }

  Widget _pageWidget() {
    return SizedBox(
      width: AppSize.width(),
      height: AppSize.height(),
      child: Stack(
        children: [
          SafeArea(
            child: Container(
              width: AppSize.width(),
              height: AppSize.height(),
              margin: EdgeInsets.symmetric(
                vertical: AppMargin.vertical(),
                horizontal: AppMargin.horizontal(),
              ),
              child: (controller.isLoadData.value)
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _nameWidget(),
                        SizedBox(height: AppSize.width() * 0.03),
                        _fieldsListWidget()
                      ],
                    )
                  : LoadingDataWidget(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _nameWidget() {
    return FadeIn(
      duration: const Duration(milliseconds: 1000),
      child: TextWidget(
        controller.arenaInformation?.name ?? '',
        fontFamily: AppFontFamily.leagueSpartan,
        fontWeight: FontWeight.w600,
        dsize: RelSize(size: TextWidgetSizes.normal),
        color: controller.theme.black.value,
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _fieldsListWidget() {
    return Expanded(
      child: FadeIn(
        duration: const Duration(milliseconds: 1000),
        child: SizedBox(
          height: AppSize.height() * 0.8,
          child: ListView.builder(
            padding: EdgeInsets.only(bottom: AppMargin.vertical() * 2),
            scrollDirection: Axis.vertical,
            itemCount: controller.fields.length,
            itemBuilder: (context, index) {
              var item = controller.fields[index];
              return InkWell(
                onTap: () => controller.showFieldInformation(item),
                child: _fieldItemWidget(item),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _fieldItemWidget(Field item) {
    return SizedBox(
      width: AppSize.width() * 0.8,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: SliderNetworkImageWidget(
              images: item.images!,
              showIndicator: true,
            ),
          ),
          SizedBox(
            width: AppSize.width() * 0.9,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextWidget(
                  '# ${item.order}',
                  fontFamily: AppFontFamily.leagueSpartan,
                  color: controller.theme.black.value,
                ),
                TextWidget(
                  '${item.players} vs ${item.players}',
                  fontFamily: AppFontFamily.leagueSpartan,
                  color: controller.theme.black.value,
                ),
              ],
            ),
          ),
          SizedBox(height: AppSize.width() * 0.1),
        ],
      ),
    );
  }
}
