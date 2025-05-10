import 'package:bukeet/preferences/user_preferences.dart';
import 'package:bukeet/services/models/arena.dart';
import 'package:bukeet/services/models/field.dart';
import 'package:bukeet/services/providers/arena_provider.dart';
import 'package:bukeet/services/providers/field_provider.dart';
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
  final priceInputController = TextEditingController();
  final List<int> fieldCapacities = [5, 6, 7, 8, 9, 10, 11];

  var fields = <Field>[].obs;
  var fieldInformation = <Field>[].obs;
  var isLoadData = false.obs;

  var capacitySelected = 0.obs;

  var maxOrder = 0.obs;

  var images = <String>[].obs;

  final _fieldsProvider = FieldProvider();
  final _arenasProvider = ArenaProvider();
  final _profileImageProvider = ImagesBucketProvider();
  final ImagePicker _picker = ImagePicker();

  void startController() async {
    getArenaInformation();
    updateLoadData(true);
  }

  Future<void> getArenaInformation() async {
    var data = await _fieldsProvider.getFieldByArenaId(
        arenaId: arenaInformation?.id ?? 0);
    fields.value = data;
    calcularMaxorder();
  }

  void calcularMaxorder() {
    if (fields.isEmpty) {
      maxOrder.value = 1;
    } else {
      final max = fields.map((f) => f.order).reduce((a, b) => a! > b! ? a : b);
      maxOrder.value = max! + 1;
    }
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
    var field = await _arenasProvider.registerArena(
        arena: Arena(
            ownerId: _preferences.getUserId(),
            name: 'maxOrder.value',
            address: 'cra 15'));
    if (field != null) {
      await validatePhotosPermission(field.id ?? 0);
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
    if (images.length >= 2) {
      Get.snackbar('warning'.tr, 'Solo puedes subir hasta 3 imágenes');
      return;
    }

    try {
      final pickedFiles = await _picker.pickMultiImage();

      if (pickedFiles.isNotEmpty) {
        final remainingSlots = 2 - images.length;
        final filesToUpload = pickedFiles.take(remainingSlots).toList();

        for (var fileData in filesToUpload) {
          final file = ImageUtils.xFileToFile(fileData);

          if (file != null) {
            final publicUrl = await _profileImageProvider.setFieldsImage(file);

            if (publicUrl != null && publicUrl.isNotEmpty) {
              images.add(publicUrl);
            }
          }
        }

        if (images.isNotEmpty) {
          final success = await _fieldsProvider.uploadFieldsImagesList(
            id: fieldId,
            imageUrls: images,
          );

          if (success) {
            Get.snackbar('warning'.tr, 'image_saved'.tr);
            onFinish();
          } else {
            Get.snackbar('warning'.tr, 'could_not_save'.tr);
          }
        }
      }
    } catch (exception, stackTrace) {
      LogError.capture(exception, stackTrace, 'uploadFieldImages');
    }
  }
}
