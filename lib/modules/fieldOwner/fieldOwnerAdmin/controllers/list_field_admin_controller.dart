import 'package:bukeet/flows/fieldOwner/fieldOwnerAdmin/controllers/field_owner_admin_flow.dart';
import 'package:bukeet/services/models/arena.dart';
import 'package:bukeet/services/models/field.dart';
import 'package:bukeet/services/providers/field_provider.dart';
//import 'package:bukeet/services/providers/field_provider.dart';
import 'package:bukeet/theme/theme.dart';
import 'package:get/get.dart';

class ListFieldAdminController extends GetxController {
  final AppTheme theme;
  //final Function(String) onClick;
  final Arena? arenaInformation;
  final Function(Field) onNext;

  ListFieldAdminController({
    required this.theme,
    required this.onNext,
    //required this.onClick,
    this.arenaInformation,
  });

  var fields = <Field>[].obs;
  var isLoadData = false.obs;

  final _fieldsProvider = FieldProvider();
  final _fieldAdminFlow = Get.find<FieldOwnerAdminFlow>();
  

  void startController() async {
    fields.value = await _fieldsProvider.getFieldByArenaId(
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

  void createField(){
    _fieldAdminFlow.startCreateFieldAdminFlow();
  }
}
