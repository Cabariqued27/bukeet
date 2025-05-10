import 'package:bukeet/flows/fieldOwner/arenaOwnerAdmin/routes/arena_admin_routes.dart';
import 'package:bukeet/flows/user/home/controllers/home_admin_flow.dart';
import 'package:bukeet/services/models/field.dart';
import 'package:get/get.dart';

class ArenaOwnerAdminFlow extends GetxController {
  Field? _field;

  final _homeFlow = Get.find<HomeUserFlow>();

  void startCreateArenaAdminFlow() {
    Get.toNamed(ArenaAdminRoutes().createArenaAdmin);
    return;
  }

  Field? getField() {
    return _field;
  }

  void setField(Field? value) {
    _field = value;
  }

  void finish() {
    deleteAllData();
    _homeFlow.start();
  }

  void deleteAllData() {
    _field = null;
  }
}
