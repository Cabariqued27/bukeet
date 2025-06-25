import 'package:bukeet/services/models/arena.dart';
import 'package:bukeet/services/models/field.dart';
import 'package:bukeet/services/providers/field_provider.dart';
import 'package:bukeet/storage/provider/images_bucket_provider.dart';
import 'package:bukeet/theme/theme.dart';
import 'package:bukeet/utils/global/log_error_utils.dart';
import 'package:bukeet/utils/images/image_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class CreateFieldAdminController extends GetxController {
  final AppTheme theme;
  final Arena? arenaInformation;
  final Function onFinish;

  CreateFieldAdminController({
    required this.theme,
    this.arenaInformation,
    required this.onFinish,
  });

  final priceInputController = TextEditingController();
  final List<int> fieldCapacities = [5, 6, 7, 8, 9, 10, 11];

  var fields = <Field>[].obs;
  var fieldInformation = <Field>[].obs;
  var isLoadData = false.obs;
  var activateNext = false.obs;

  var capacitySelected = 0.obs;

  var maxOrder = 0.obs;

  var images = <String>[].obs;
  var selectedFiles = <XFile>[].obs;

  final _fieldsProvider = FieldProvider();
  final _profileImageProvider = ImagesBucketProvider();
  final ImagePicker _picker = ImagePicker();

  void startController() async {
    getArenaInformation();
    updateLoadData(true);
  }

  Future<void> getArenaInformation() async {
    var data = await _fieldsProvider.getFieldByArenaId(
      arenaId: arenaInformation?.id ?? 0,
    );
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

  void updateActivateNext(bool value) {
    activateNext.value = value;
    update();
  }

  void onChangeForm() {
    if (capacitySelected.value != 0 && selectedFiles.isNotEmpty) {
      updateActivateNext(true);
    } else {
      updateActivateNext(false);
    }
  }

  void setSelectedFieldCapacity(int value) {
    capacitySelected.value = value;
    update();
    onChangeForm();
  }

  Future<void> createField() async {
    updateActivateNext(false);
    var field = await _fieldsProvider.registerField(
      field: Field(
        players: capacitySelected.value,
        order: maxOrder.value,
        arenaId: arenaInformation?.id,
      ),
    );

    if (field != null) {
      await uploadFieldImages(field.id!);
    }
  }

  Future<void> validatePhotosPermission(int id) async {
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      uploadFieldImages(id);

      return;
    }

    uploadFieldImages(id);
  }

  Future<void> pickImages() async {
    if (selectedFiles.length >= 3) {
      Get.snackbar('warning'.tr, 'Solo puedes seleccionar hasta 3 imágenes');
      return;
    }

    try {
      final picked = await _picker.pickMultiImage();

      if (picked.isNotEmpty) {
        final remaining = 3 - selectedFiles.length;
        final toAdd = picked.take(remaining);

        selectedFiles.addAll(toAdd);
        onChangeForm();
      }
    } catch (e, st) {
      LogError.capture(e, st, 'pickImages');
    }
  }

  Future<void> uploadFieldImages(int fieldId) async {
    if (selectedFiles.isEmpty) return;

    try {
      for (var xfile in selectedFiles) {
        final file = ImageUtils.xFileToFile(xfile);
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
          Get.snackbar('Éxito', 'Imágenes subidas correctamente');
          onFinish();
        } else {
          Get.snackbar('Error', 'No se pudieron subir las imágenes');
        }
      }
    } catch (e, st) {
      LogError.capture(e, st, 'uploadFieldImages');
    }
  }
}
