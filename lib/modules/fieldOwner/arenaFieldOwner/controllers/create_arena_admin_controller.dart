import 'package:bukeet/preferences/user_preferences.dart';
import 'package:bukeet/services/models/arena.dart';
import 'package:bukeet/services/providers/arena_provider.dart';
import 'package:bukeet/storage/provider/images_bucket_provider.dart';
import 'package:bukeet/theme/theme.dart';
import 'package:bukeet/utils/global/log_error_utils.dart';
import 'package:bukeet/utils/images/image_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class CreateArenaAdminController extends GetxController {
  final AppTheme theme;
  final Arena? arenaInformation;
  final Function onFinish;

  CreateArenaAdminController({
    required this.theme,
    this.arenaInformation,
    required this.onFinish,
  });
  final _preferences = UserPreferences();
  final arenaNameInputController = TextEditingController();
  final arenaAddressInputController = TextEditingController();
  final arenaCityInputController = TextEditingController();

  final List<int> fieldCapacities = [5, 6, 7, 8, 9, 10, 11];

  var isLoadData = false.obs;
  var activateNext = false.obs;
  var capacitySelected = 0.obs;
  var maxOrder = 0.obs;

  var images = ''.obs;

  final _arenasProvider = ArenaProvider();
  final _profileImageProvider = ImagesBucketProvider();
  final ImagePicker _picker = ImagePicker();

  void startController() async {
    updateLoadData(true);
  }

  void updateLoadData(bool value) {
    isLoadData.value = value;
    update();
  }

  void setSelectedFieldCapacity(int value) {
    capacitySelected.value = value;
    update();
  }

  Future<void> createField() async {
    
      var arena = await _arenasProvider.registerArena(
        arena: Arena(
            ownerId: _preferences.getUserId(),
            name: arenaNameInputController.text,
            address: arenaAddressInputController.text,
            city: arenaCityInputController.text));
    if (arena != null) {
      await validatePhotosPermission(arena.id ?? 0);
    }
    
    
  }

  Future<void> validatePhotosPermission(int id) async {
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      uploadFieldImages(id);

      return;
    }

    uploadFieldImages(id);
  }

  Future<void> uploadFieldImages(int fieldId) async {
    /*if (images.isNotEmpty) {
    Get.snackbar('warning'.tr, 'Solo puedes subir una imagen');
    return;
  }*/

    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        final file = ImageUtils.xFileToFile(pickedFile);

        if (file != null) {
          final publicUrl = await _profileImageProvider.setArenasImage(file);

          if (publicUrl != null && publicUrl.isNotEmpty) {
            images.value = publicUrl;

            final success = await _arenasProvider.uploadarenaImagesList(
              id: fieldId,
              imageUrls: images.value,
            );

            if (success) {
              Get.snackbar('warning'.tr, 'image_saved'.tr);
              onFinish();
            } else {
              Get.snackbar('warning'.tr, 'could_not_save'.tr);
            }
          }
        }
      }
    } catch (exception, stackTrace) {
      LogError.capture(exception, stackTrace, 'uploadFieldImages');
    }
  }

  void onChangedLoginForm() {
    if (arenaNameInputController.text.isNotEmpty &&
        arenaAddressInputController.text.isNotEmpty &&
        arenaCityInputController.text.isNotEmpty) {
      activateNext.value = true;
    }else{
      activateNext.value = false;
    }
    update();
  }
}
