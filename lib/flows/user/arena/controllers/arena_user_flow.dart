import 'package:bukeet/flows/user/arena/routes/arena_user_routes.dart';
import 'package:bukeet/flows/user/home/controllers/home_admin_flow.dart';
import 'package:bukeet/services/models/arena.dart';
import 'package:bukeet/services/models/field.dart';
import 'package:get/get.dart';

class ArenaUserFlow extends GetxController {
  Field? _field;
  Arena? _arena;

  final _homeFlow = Get.find<HomeUserFlow>();

  void startFields(Arena item) async {
    setArena(item);
    Get.toNamed(ArenaUserRoutes().userFields);
    return;
  }

  Field? getField() {
    return _field;
  }

  Arena? getArena() {
    return _arena;
  }

  void setField(Field? value) {
    _field = value;
  }

  void setArena(Arena? value) {
    _arena = value;
  }

  void finish() {
    deleteAllData();
    _homeFlow.start();
  }

  void deleteAllData() {
    _field = null;
    _arena = null;
  }
}
