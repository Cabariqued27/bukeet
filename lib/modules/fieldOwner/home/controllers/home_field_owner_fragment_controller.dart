import 'package:bukeet/flows/fieldOwner/arenaOwnerAdmin/controllers/arena_owner_admin_flow.dart';
import 'package:bukeet/flows/fieldOwner/fieldOwnerAdmin/controllers/field_owner_admin_flow.dart';
import 'package:bukeet/preferences/user_preferences.dart';
import 'package:bukeet/services/models/arena.dart';
import 'package:bukeet/services/models/field.dart';
import 'package:bukeet/services/providers/arena_provider.dart';
import 'package:bukeet/theme/theme.dart';
import 'package:get/get.dart';

class HomeFieldOwnerFragmentController extends GetxController {
  final AppTheme theme;
  //final Function(String) onClick;

  HomeFieldOwnerFragmentController({
    required this.theme,
    //required this.onClick,
  });

  var fields = <Field>[].obs;
  var arenas = <Arena>[].obs;
  var isLoadData = false.obs;

  final _preferences = UserPreferences();

  final _arenasProvider = ArenaProvider();

  final _fieldAdminFlow = Get.find<FieldOwnerAdminFlow>();

  final _arenaAdminFlow = Get.find<ArenaOwnerAdminFlow>();

  void startController() async {
    /*fields.value = await _fieldsProvider.getFieldByArenaId(
        arenaId: _preferences.getUserId());*/
    arenas.value = await _arenasProvider.getArenaByUserId(
        ownerId: _preferences.getUserId());
    updateLoadData(true);
  }

  void updateLoadData(bool value) {
    isLoadData.value = value;
    update();
  }

  void showFields(Arena item) {
    _fieldAdminFlow.startEditFieldAdminFlow(item);
  }

  /*void createField(Arena item){
    _fieldAdminFlow.startCreateFieldAdminFlow(item);
  }*/

  void createArena() {
    _arenaAdminFlow.startCreateArenaAdminFlow();
  }
}
