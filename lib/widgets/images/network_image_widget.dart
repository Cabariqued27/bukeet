import 'package:bukeet/assets/app_assets.dart';
import 'package:bukeet/widgets/images/asset_image_widget.dart';
import 'package:bukeet/widgets/loading/loading_data_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_fade/image_fade.dart';

class NetworkImageWidget extends StatelessWidget {
  final String imageUrl;
  final double width;
  final double height;
  final BoxFit fit;
  final bool? isUser;

  const NetworkImageWidget({
    Key? key,
    required this.imageUrl,
    this.width = double.infinity,
    this.height = double.infinity,
    this.fit = BoxFit.cover,
    this.isUser = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _widgetContent();
  }

  Widget _widgetContent() {
    if (imageUrl.isNotEmpty && imageUrl != 'null') {
      return SizedBox(
        width: width,
        height: height,
        child: ImageFade(
          image: NetworkImage(imageUrl),
          duration: const Duration(milliseconds: 900),
          syncDuration: const Duration(milliseconds: 150),
          alignment: Alignment.center,
          fit: fit,
          placeholder: Container(
            color: Colors.transparent,
            alignment: Alignment.center,
          ),
          loadingBuilder: (context, progress, chunkEvent) {
            return LoadingDataWidget();
          },
          errorBuilder: (context, err) {
            printError(info: err.toString());
            return _errorImageWidget();
          },
        ),
      );
    }

    return _errorImageWidget();
  }

  Widget _errorImageWidget() {
    return SizedBox(
      width: width,
      height: height,
      child: AssetImageWidget(
        fit: fit,
        pathImage:
            (isUser == true) ? AppImages.noUserImage : AppImages.noFoundImage,
      ),
    );
  }
}
