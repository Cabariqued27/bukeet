import 'package:bukeet/preferences/user_preferences.dart';
import 'package:bukeet/services/models/arena.dart';
import 'package:bukeet/services/models/field.dart';
import 'package:bukeet/services/models/reservation.dart';
import 'package:bukeet/services/providers/arena_provider.dart';
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

  var arenas = <Arena>[].obs;
  var fields = <Field>[].obs;
  var reservations = <Reservation>[].obs;
  final fieldIdToArenaName = <int, String>{};

  var isLoadData = false.obs;

  final _reservationsProvider = ReservationProvider();
  final _fieldsProvider = FieldProvider();
  final _arenasProvider = ArenaProvider();

  final _preferences = UserPreferences();

  void startController() async {
    updateLoadData(false);
    await getArenaByUserId();
    await getFieldByUserId();
    await getReservations();
    updateLoadData(true);
  }

  Future<void> getArenaByUserId() async {
    arenas.clear();
    arenas.value = await _arenasProvider.getArenaByUserId(
      ownerId: _preferences.getUserId(),
    );
  }

  Future<void> getFieldByUserId() async {
    fields.clear();
    fieldIdToArenaName.clear();

    final futures = arenas.map((arena) async {
      var data = await _fieldsProvider.getFieldByArenaId(
        arenaId: arena.id ?? 0,
      );
      for (var field in data) {
        if (field.id != null) {
          fieldIdToArenaName[field.id!] = arena.name ?? 'Sin nombre';
        }
      }
      return data;
    }).toList();

    final results = await Future.wait(futures);
    fields.addAll(results.expand((e) => e));
  }

  Future<void> getReservations() async {
    reservations.clear();

    final futures = fields.map((field) async {
      return await _reservationsProvider.getReservationsByFieldsId(
        fieldId: field.id ?? 0,
      );
    }).toList();

    final results = await Future.wait(futures);
    reservations.addAll(results.expand((e) => e));
  }

  Future<void> updateReservationStatus(Reservation reservation) async {
    //var updateReservation = UpdateReservation(
    //  id: reservation.id ?? 0, status: !(reservation.status ?? false));
    //await _reservationsProvider.updateReservationStatus(
    //  updateReservation: updateReservation);
    //startController();
  }

  String formatHour(int hour24) {
    final int hour12 = hour24 % 12 == 0 ? 12 : hour24 % 12;
    final String period = hour24 < 12 ? 'AM' : 'PM';
    return '$hour12:00 $period';
  }

  void updateLoadData(bool value) {
    isLoadData.value = value;
    update();
  }
}
