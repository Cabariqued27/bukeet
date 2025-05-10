import 'package:bukeet/flows/fieldOwner/fieldOwnerAdmin/routes/field_admin_routes.dart';
import 'package:bukeet/flows/user/home/controllers/home_admin_flow.dart';
import 'package:bukeet/services/models/arena.dart';
import 'package:bukeet/services/models/field.dart';
import 'package:get/get.dart';

class FieldOwnerAdminFlow extends GetxController {
  Field? _field;
  Arena? _arena;

  final _homeFlow = Get.find<HomeUserFlow>();

  void startEditFieldAdminFlow(Arena item) {
    setArena(item);
    Get.toNamed(FieldAdminRoutes().listFieldAdmin);
    return;
  }

  void startCreateFieldAdminFlow() {
    Get.toNamed(FieldAdminRoutes().createFieldAdmin);
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
