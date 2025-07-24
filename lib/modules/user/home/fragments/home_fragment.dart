import 'package:animate_do/animate_do.dart';
import 'package:bukeet/modules/user/home/controllers/home_user_fragment_controller.dart';
import 'package:bukeet/services/models/arena.dart';
import 'package:bukeet/utils/app/app_margin.dart';
import 'package:bukeet/utils/app/app_size.dart';
import 'package:bukeet/widgets/images/network_image_widget.dart';
import 'package:bukeet/widgets/inputs/search_input_widget.dart';
import 'package:bukeet/widgets/loading/loading_data_widget.dart';
import 'package:bukeet/widgets/responsive/responsive_widget.dart';
import 'package:bukeet/widgets/responsive/web_frame_widget.dart';
import 'package:bukeet/widgets/text/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeUserFragment extends StatelessWidget {
  final HomeUserFragmentController controller;

  const HomeUserFragment({
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
      child: SafeArea(
        child: Container(
          width: AppSize.width(),
          height: AppSize.height(),
          margin: EdgeInsets.symmetric(
            vertical: AppMargin.vertical(),
            horizontal: AppMargin.horizontal(),
          ),
          child: (controller.isLoadData.value)
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _searchWidget(),
                    //SizedBox(height: AppSize.width() * 0.03),
                    _fieldsListWidget()
                  ],
                )
              : LoadingDataWidget(),
        ),
      ),
    );
  }

  Widget _searchWidget() {
    return SearchInputWidget(
      hintText: 'where_you_want_play'.tr,
      textInputType: TextInputType.text,
      controller: controller.searchController,
      onChanged: (value) => controller.filterFields(value),
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
            itemCount: controller.arenasFiltered.length,
            itemBuilder: (context, index) {
              var item = controller.arenasFiltered[index];
              return InkWell(
                onTap: () => controller.showArena(item),
                child: _fieldItemWidget(item),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _fieldItemWidget(Arena item) {
    return SizedBox(
      width: AppSize.width() * 0.8,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: SizedBox(
              height: AppSize.height() * 0.3,
              width: double.infinity,
              child: NetworkImageWidget(
                imageUrl: item.imageUrl ?? '',
              ),
            ),
          ),
          SizedBox(
            width: AppSize.width() * 0.9,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextWidget(
                  '${item.name}',
                  fontFamily: AppFontFamily.leagueSpartan,
                  fontWeight: TextWidgetWeight.bold,
                  color: controller.theme.black.value,
                ),
                TextWidget(
                  '${item.address}',
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
