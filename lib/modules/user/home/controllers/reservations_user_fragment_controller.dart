import 'package:bukeet/preferences/user_preferences.dart';
import 'package:bukeet/services/models/field.dart';
import 'package:bukeet/services/models/reservation.dart';
import 'package:bukeet/services/providers/field_provider.dart';
import 'package:bukeet/services/providers/reservation_provider.dart';
import 'package:bukeet/theme/theme.dart';
import 'package:get/get.dart';

class ReservationsUserFragmentController extends GetxController {
  final AppTheme theme;
  //final Function(String) onClick;

  ReservationsUserFragmentController({
    required this.theme,
    //required this.onClick,
  });

  var reservations = <Reservation>[].obs;
  var fields = <Field>[].obs;
  var isLoadData = false.obs;
  

  final _reservationsProvider = ReservationProvider();
  final _fieldsProvider = FieldProvider();


  final _preferences = UserPreferences();

  void startController() async {
    await getReservationsById();
    await getFieldsInformation();
    
    updateLoadData(true);
  }

  Future<void> refreshData() async {
    updateLoadData(false);
    reservations.clear();
    fields.clear();
    await getReservationsById();
    await getFieldsInformation();

    updateLoadData(true);
    update();
  }

  Future<void> getReservationsById() async {
    var data = await _reservationsProvider.getReservationsById(
      userId: _preferences.getUserId(),
    );
    reservations.value = data;
  }

  Future<void> getFieldsInformation() async {
    var data = await _fieldsProvider.getFields();
    fields.value = data;
  }

  

  void updateLoadData(bool value) {
    isLoadData.value = value;
    update();
  }

  String formatHour(int hour24) {
    final int hour12 = hour24 % 12 == 0 ? 12 : hour24 % 12;
    final String period = hour24 < 12 ? 'AM' : 'PM';
    return '$hour12:00 $period';
  }
}
