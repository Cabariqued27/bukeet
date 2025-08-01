import 'package:bukeet/utils/app/app_size.dart';
import 'package:bukeet/utils/global/apply_opacity_util.dart';
import 'package:bukeet/widgets/images/controllers/slider_network_image_controller.dart';
import 'package:bukeet/widgets/images/network_image_widget.dart';
import 'package:bukeet/widgets/loading/loading_data_widget.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SliderNetworkImageWidget extends StatelessWidget {
  final List<dynamic> images;
  final bool showIndicator;
  const SliderNetworkImageWidget({
    super.key,
    required this.images,
    required this.showIndicator,
  });

  @override
  Widget build(BuildContext context) {
    String uniqueTag = UniqueKey().toString();

    return GetBuilder<SliderNetworkImageController>(
      init: SliderNetworkImageController(images),
      tag: uniqueTag,
      builder: (controller) {
        return _widgetContent(controller, showIndicator);
      },
    );
  }
}

Widget _widgetContent(
  SliderNetworkImageController controller,
  bool showIndicator,
) {
  return Column(
    children: [
      (controller.isLoadData.value)
          ? _sliderWidget(controller)
          : LoadingDataWidget(),
      (showIndicator) ? _dotsWidget(controller) : const SizedBox(),
    ],
  );
}

Widget _sliderWidget(SliderNetworkImageController controller) {
  var items = List<Widget>.generate(controller.images.length, (index) {
    return _imageWidget(index, controller);
  });

  return CarouselSlider(
    items: items,
    carouselController: controller.sliderController,
    options: CarouselOptions(
      autoPlay: false,
      reverse: true,
      enlargeCenterPage: false,
      disableCenter: false,
      viewportFraction: 1.0,
      aspectRatio: 2.0,
      initialPage: controller.current.value,
      scrollDirection: Axis.horizontal,
      enableInfiniteScroll: true,
      onPageChanged: (index, reason) {
        controller.animateToPage(index);
      },
    ),
  );
}

Widget _imageWidget(int index, SliderNetworkImageController controller) {
  var image = controller.images[index];

  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 5.0),
    child: _defaultTypeBannerWidget(image),
  );
}

Widget _defaultTypeBannerWidget(String image) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(20.0),
    child: NetworkImageWidget(
      width: AppSize.width() * 0.9,
      height: double.infinity,
      imageUrl: image,
      fit: BoxFit.cover,
    ),
  );
}

Widget _dotsWidget(SliderNetworkImageController controller) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: controller.images.asMap().entries.map((entry) {
      return GestureDetector(
        onTap: () => controller.animateToPage(entry.key),
        child: Container(
          width: 8.0,
          height: 8.0,
          margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 4.0),
          decoration: (controller.current.value == entry.key)
              ? BoxDecoration(
                  shape: BoxShape.circle,
                  color: controller.theme.refreshBackground.value,
                )
              : BoxDecoration(
                  shape: BoxShape.circle,
                  color: controller.theme.background.value,
                  border: Border.all(
                    color: applyOpacity(controller.theme.gray.value, 0.5),
                  ),
                ),
        ),
      );
    }).toList(),
  );
}
