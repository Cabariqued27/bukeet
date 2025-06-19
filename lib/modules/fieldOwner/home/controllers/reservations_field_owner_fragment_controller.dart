import 'package:bukeet/preferences/user_preferences.dart';
import 'package:bukeet/services/models/field.dart';
import 'package:bukeet/services/models/reservation.dart';
import 'package:bukeet/services/providers/field_provider.dart';
import 'package:bukeet/services/providers/reservation_provider.dart';
import 'package:bukeet/theme/theme.dart';
import 'package:get/get.dart';

class ReservationsFieldOwnerFragmentController extends GetxController {
  final AppTheme theme;
  //final Function(String) onClick;

  ReservationsFieldOwnerFragmentController({
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
    updateLoadData(false);
    await getFieldByUserId();
    //await getReservations();
    updateLoadData(true);
  }

  Future<void> getFieldByUserId() async {
    fields.clear();
    fields.value = await _fieldsProvider.getFieldByArenaId(
        arenaId: _preferences.getUserId());
  }

  Future<void> getReservations() async {
    reservations.clear();
    for (var element in fields) {
      var data = await _reservationsProvider.getReservationsByFieldsId(
          fieldId: element.id ?? 0);
      reservations.addAll(data);
    }
  }

  Future<void> updateReservationStatus(Reservation reservation) async {
    //var updateReservation = UpdateReservation(
      //  id: reservation.id ?? 0, status: !(reservation.status ?? false));
    //await _reservationsProvider.updateReservationStatus(
      //  updateReservation: updateReservation);
    startController();
  }

  void updateLoadData(bool value) {
    isLoadData.value = value;
    update();
  }
}
