import 'package:bukeet/flows/user/arena/controllers/arena_user_flow.dart';
import 'package:bukeet/services/models/arena.dart';
import 'package:bukeet/services/models/field.dart';
import 'package:bukeet/services/providers/field_provider.dart';
import 'package:bukeet/theme/theme.dart';
import 'package:get/get.dart';

class HomeAdminFragmentController extends GetxController {
  final AppTheme theme;
  //final Function(String) onClick;

  HomeAdminFragmentController({
    required this.theme,
    //required this.onClick,
  });

  var fields = <Field>[].obs;
  var isLoadData = false.obs;

  final _fieldsProvider = FieldProvider();

  final _arenaUserFlow = Get.find<ArenaUserFlow>();

  void startController() async {
    fields.value = await _fieldsProvider.getFieldsWithOutVerification();
    updateLoadData(true);
  }

  void updateLoadData(bool value) {
    isLoadData.value = value;
    update();
  }

  void doDooking(Arena item) {
    _arenaUserFlow.startFields(item);
  }
}
