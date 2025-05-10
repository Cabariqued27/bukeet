import 'package:bukeet/flows/user/arena/controllers/arena_user_flow.dart';
import 'package:bukeet/services/models/arena.dart';
import 'package:bukeet/services/providers/arena_provider.dart';
import 'package:bukeet/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeUserFragmentController extends GetxController {
  final AppTheme theme;
  //final Function(String) onClick;

  HomeUserFragmentController({
    required this.theme,
    //required this.onClick,
  });

  final searchController = TextEditingController();

  var arenas = <Arena>[].obs;
  var arenasFiltered = <Arena>[].obs;
  var isLoadData = false.obs;
  final _arenaProvider = ArenaProvider();
  final _arenaUserFlow = Get.find<ArenaUserFlow>();

  void startController() async {
    arenas.value = await _arenaProvider.getArenas();
    arenasFiltered.value = arenas;
    updateLoadData(true);
  }

  void updateLoadData(bool value) {
    isLoadData.value = value;
    update();
  }

  void showArena(Arena item) {
    _arenaUserFlow.startFields(item);
  }

  void filterFields(String query) {
    if (query.isEmpty) {
      arenasFiltered.value = arenas;
    } else {
      arenasFiltered.value = arenas
          .where((field) =>
              field.name?.toLowerCase().contains(query.toLowerCase()) ?? false)
          .toList();
    }
  }
}
