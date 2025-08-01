import 'package:bukeet/widgets/images/controllers/full_slider_network_image_controller.dart';
import 'package:bukeet/widgets/images/network_image_widget.dart';
import 'package:bukeet/widgets/loading/loading_data_widget.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FullSliderNetworkImageWidget extends StatelessWidget {
  final List<dynamic> images;
  const FullSliderNetworkImageWidget({
    super.key,
    required this.images,
  });

  @override
  Widget build(BuildContext context) {
    String uniqueTag = UniqueKey().toString();

    return GetBuilder<FullSliderNetworkImageController>(
      init: FullSliderNetworkImageController(images),
      tag: uniqueTag,
      builder: (controller) {
        return _widgetContent(controller);
      },
    );
  }
}

Widget _widgetContent(FullSliderNetworkImageController controller) {
  return (controller.isLoadData.value)
      ? _sliderWidget(controller)
      : LoadingDataWidget();
}


Widget _sliderWidget(FullSliderNetworkImageController controller) {
  var items = List<Widget>.generate(controller.images.length, (index) {
    return _imageWidget(index, controller);
  });

  return CarouselSlider(
    items: items,
    carouselController: controller.sliderController,
    options: CarouselOptions(
      height: double.infinity, 
      autoPlay: false,
      reverse: true,
      enlargeCenterPage: false,
      disableCenter: false,
      viewportFraction: 1.0,
      initialPage: controller.current.value,
      scrollDirection: Axis.horizontal,
      enableInfiniteScroll: true,
      onPageChanged: (index, reason) {
        controller.animateToPage(index);
      },
    ),
  );
}




Widget _imageWidget(int index, FullSliderNetworkImageController controller) {
  var image = controller.images[index];

  return SizedBox.expand( // 👈 Asegura que cada slide también use todo el espacio
    child: _defaultTypeBannerWidget(image),
  );
}

Widget _defaultTypeBannerWidget(String image) {
  return NetworkImageWidget(
    imageUrl: image,
    fit: BoxFit.cover,
  );
}




