import 'package:bukeet/services/models/arena.dart';
import 'package:bukeet/services/models/field.dart';
import 'package:bukeet/services/providers/field_provider.dart';
import 'package:bukeet/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FieldsUserController extends GetxController {
  final AppTheme theme;
  final Arena? arenaInformation;
  final VoidCallback onBack;
  final Function(Field) onNext;
  //final Function(String) onClick;

  FieldsUserController({
    required this.onNext,
    required this.onBack,
    required this.theme,
    this.arenaInformation,

    //required this.onClick,
  });

  final searchController = TextEditingController();

  var fields = <Field>[].obs;
  var isLoadData = false.obs;
  final _fieldProvider = FieldProvider();

  void startController() async {
    fields.value = await _fieldProvider.getFieldByArenaId(
        arenaId: arenaInformation?.id ?? 0);
    updateLoadData(true);
  }

  void updateLoadData(bool value) {
    isLoadData.value = value;
    update();
  }

  void showFieldInformation(Field item) {
    onNext(item);
  }
}
