import 'package:bukeet/services/models/arena.dart';
import 'package:bukeet/services/models/field.dart';
import 'package:bukeet/services/models/hour_avaliability.dart';
import 'package:bukeet/services/models/hour_data.dart';
import 'package:bukeet/services/providers/field_provider.dart';
import 'package:bukeet/services/providers/hour_avaliability_provider.dart';
import 'package:bukeet/theme/theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditFieldAdminController extends GetxController {
  final AppTheme theme;
  final Field? fieldInformation;
  final Arena? arenaInformation;

  EditFieldAdminController({
    required this.theme,
    this.fieldInformation,
    this.arenaInformation,
  });

  final Map<String, Map<int, TextEditingController>> priceControllers = {};

  var fields = <Field>[].obs;
  var isLoadData = false.obs;
  var activeStatus = false.obs;
  var capacitySelected = 0.obs;
  var price = 0.0.obs;
  var images = <String>[].obs;

  var hourAvailability = <String, HourAvailability>{}.obs;

  final List<String> daysOfWeek = [
    'monday',
    'tuesday',
    'wednesday',
    'thursday',
    'friday',
    'saturday',
    'sunday',
  ];
  var daysOfWeekIndex = 0.obs;

  final _hourAvailabilityProvider = HourAvailabilityProvider();
  final _fieldsProvider = FieldProvider();
  //final _profileImageProvider = ImagesBucketProvider();

  void startController() async {
    await initializeAvailabilityIfNeeded(fieldInformation?.id ?? 0);
    initializePriceControllers();
    updateLoadData(true);
  }

  void initializePriceControllers() {
    for (var day in daysOfWeek) {
      final availability = hourAvailability[day];
      if (availability == null) continue;

      final prices = availability.arrayPrice ?? [];
      priceControllers[day] = {};

      for (int hour = 0; hour < prices.length; hour++) {
        final controller = TextEditingController(text: prices[hour].toString());
        priceControllers[day]![hour] = controller;
      }
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
    _fieldsProvider.registerField(
      field: Field(players: capacitySelected.value),
    );
  }

  /*Future<void> validatePhotosPermission() async {
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      var permissionStatus = await getPhotosPermission();
      if (permissionStatus) {
        onChangeProfileImage();
      }
      return;
    }

    onChangeProfileImage();
  }*/

  /*Future<void> onChangeProfileImage() async {
    if (images.length >= 3) {
      Get.snackbar('warning'.tr, 'Solo puedes subir hasta 3 imágenes');
      return;
    }

    try {
      final fileData = await _picker.pickImage(source: ImageSource.gallery);

      if (fileData != null) {
        final file = ImageUtils.xFileToFile(fileData);

        if (file != null) {
          final publicUrl = await _profileImageProvider.setFieldsImage(file);

          if (publicUrl != null && publicUrl.isNotEmpty) {
            Get.snackbar('warning'.tr, 'image_saved'.tr);

            if (publicUrl.isNotEmpty) {
              images.add(publicUrl);

              final success = await _fieldsProvider.uploadFieldsImagesList(
                id: fieldInformation?.id ?? 0,
                imageUrls: images,
              );

              if (!success) {
                Get.snackbar('warning'.tr, 'could_not_save'.tr);
                return;
              }
            }
          }
        }
      }
    } catch (exception, stackTrace) {
      LogError.capture(exception, stackTrace, 'onChangeProfileImage');
    }

    Get.snackbar('warning'.tr, 'could_not_save'.tr);
  }*/

  Future<void> initializeAvailabilityIfNeeded(int fieldId) async {
    final exists = await _hourAvailabilityProvider.checkAvailabilityExists(
      fieldId,
    );

    if (!exists) {
      await _hourAvailabilityProvider.initializeAvailability(fieldId);
    }

    final fetchedAvailability = await _hourAvailabilityProvider
        .fetchAvailability(fieldId);

    final grouped = <String, HourAvailability>{};
    for (var item in fetchedAvailability) {
      if (item.day != null) {
        grouped[item.day!] = item;
      }
    }
    hourAvailability.value = grouped;

    update();
  }

  Future<void> updateHourAvailability(HourAvailability availability) async {
    final success = await _hourAvailabilityProvider.updateAvailability(
      hourAvailability: availability,
    );
    Get.snackbar('warning'.tr, 'actualizado');

    if (!success) {
      if (kDebugMode) {
        print("Error al actualizar la disponibilidad");
      }
    }
  }

  final priceController = TextEditingController();

  Rx<int> selectedHour = 0.obs;

  void setPrice(double value) {
    price.value = value;
    priceController.text = value.toString();
    update();
  }

  void setActiveStatus(bool status) {
    activeStatus.value = status;
    update();
  }

  void increaseSelectedDay() {
    if (daysOfWeekIndex.value != 6) {
      daysOfWeekIndex.value = daysOfWeekIndex.value + 1;
    }
  }

  void decreaseSelectedDay() {
    if (daysOfWeekIndex.value != 0) {
      daysOfWeekIndex.value = daysOfWeekIndex.value - 1;
    }
  }

  void setSelectedHour(int hour) {
    selectedHour.value = hour;
  }

  List<HourData> getHourDataForDay(String day) {
    final availability = hourAvailability[day];
    if (availability == null) return [];

    final states = availability.arrayState ?? [];
    final prices = availability.arrayPrice ?? [];

    List<HourData> data = [];
    for (int i = 0; i < states.length; i++) {
      data.add(
        HourData(hour: i, isActive: states[i] == true, price: prices[i]),
      );
    }

    return data;
  }

  void updateHourDataForDay(String day, List<HourData> updatedData) {
    final updatedStates = updatedData.map((e) => e.isActive).toList();
    final updatedPrices = updatedData.map((e) => e.price).toList();

    hourAvailability[day] = HourAvailability(
      fieldId: hourAvailability[day]?.fieldId,
      day: day,
      arrayState: updatedStates,
      arrayPrice: updatedPrices,
    );
  }

  void updateHourDataForDayFromControllers(String day) {
    final availability = hourAvailability[day];
    if (availability == null) return;

    final controllers = priceControllers[day] ?? {};
    final updatedStates = availability.arrayState ?? [];
    final updatedPrices = List<double>.generate(24, (i) {
      final controller = controllers[i];
      if (controller != null) {
        final text = controller.text;
        return double.tryParse(text) ?? 0.0;
      }
      return 0.0;
    });

    hourAvailability[day] = HourAvailability(
      fieldId: availability.fieldId,
      day: day,
      arrayState: updatedStates,
      arrayPrice: updatedPrices,
    );
  }

  Future<void> updateSchedule() async {
    final hasInvalid = hourAvailability.values.any((availability) {
      return _hasInvalidActiveHourPrice(availability);
    });

    if (hasInvalid) {
      Get.snackbar('warning'.tr, 'la hora debe costar al menos 10.000 Cop');
      return;
    }

    for (var day in hourAvailability.keys) {
      final availability = hourAvailability[day];
      if (availability != null) {
        await updateHourAvailability(availability);
      }
    }
  }

  bool _hasInvalidActiveHourPrice(HourAvailability availability) {
    final states = availability.arrayState ?? [];
    final prices = availability.arrayPrice ?? [];

    for (int i = 0; i < states.length && i < prices.length; i++) {
      final isActive = states[i] == true || states[i] == 1;
      final price = prices[i];

      if (isActive && (price is num) && price < 10000) {
        return true;
      }
    }
    return false;
  }
}
