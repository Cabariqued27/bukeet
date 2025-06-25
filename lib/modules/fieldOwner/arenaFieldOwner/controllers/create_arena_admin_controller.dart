import 'dart:io';
import 'package:bukeet/preferences/user_preferences.dart';
import 'package:bukeet/services/models/arena.dart';
import 'package:bukeet/services/providers/arena_provider.dart';
import 'package:bukeet/storage/provider/images_bucket_provider.dart';
import 'package:bukeet/theme/theme.dart';
import 'package:bukeet/utils/global/log_error_utils.dart';
import 'package:bukeet/utils/images/image_utils.dart';
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

  var isLoadData = false.obs;
  var activateNext = false.obs;

  var selectedImage = Rxn<File>();

  final _arenasProvider = ArenaProvider();
  final _profileImageProvider = ImagesBucketProvider();
  final ImagePicker _picker = ImagePicker();

  void startController() {
    updateLoadData(true);
  }

  void updateLoadData(bool value) {
    isLoadData.value = value;
    update();
  }

  Future<void> pickImage() async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        final file = ImageUtils.xFileToFile(pickedFile);
        if (file != null) {
          selectedImage.value = file;
          onChangedLoginForm();
        }
      }
    } catch (e, st) {
      LogError.capture(e, st, 'pickImage');
    }
  }

  Future<void> createField() async {
    updateActivateNext(false);
    final arena = await _arenasProvider.registerArena(
      arena: Arena(
        ownerId: _preferences.getUserId(),
        name: arenaNameInputController.text,
        address: arenaAddressInputController.text,
        city: arenaCityInputController.text,
      ),
    );

    if (arena != null && selectedImage.value != null) {
      await uploadArenaImage(arena.id ?? 0, selectedImage.value!);
    } else {
      onFinish();
    }
  }

  Future<void> uploadArenaImage(int id, File imageFile) async {
    try {
      final publicUrl = await _profileImageProvider.setArenasImage(imageFile);
      if (publicUrl != null && publicUrl.isNotEmpty) {
        final success = await _arenasProvider.uploadarenaImagesList(
          id: id,
          imageUrls: publicUrl,
        );

        if (success) {
          Get.snackbar('Éxito', 'Imagen subida correctamente');
        } else {
          Get.snackbar('Error', 'No se pudo subir la imagen');
        }
      }
      onFinish();
    } catch (e, st) {
      LogError.capture(e, st, 'uploadArenaImage');
    }
  }

  void onChangedLoginForm() {
    updateActivateNext(
      arenaNameInputController.text.isNotEmpty &&
          arenaAddressInputController.text.isNotEmpty &&
          arenaCityInputController.text.isNotEmpty &&
          (selectedImage.value != null),
    );

    update();
  }

  void updateActivateNext(bool value) {
    activateNext.value = value;
    update();
  }
}
