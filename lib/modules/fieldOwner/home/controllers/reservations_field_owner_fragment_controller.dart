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

  ReservationsFieldOwnerFragmentController({required this.theme});

  final arenas = <Arena>[].obs;
  final fields = <Field>[].obs;
  final selectedArena = Arena().obs;
  final selectedField = Field().obs;
  final reservations = <Reservation>[].obs;

  final isLoadData = false.obs;
  final today = DateTime.now().obs;
  final dynamicDay = DateTime.now().obs;

  final _arenasProvider = ArenaProvider();
  final _fieldsProvider = FieldProvider();
  final _reservationsProvider = ReservationProvider();
  final _preferences = UserPreferences();

  Future<void> startController() async {
    updateLoadData(false);
    await getArenaByUserId();
    await getFieldByArena();
    _initializeReservations();
    await _loadReservationsForField(selectedField.value, today.value);
    updateLoadData(true);
  }

  Future<void> getArenaByUserId() async {
    arenas.clear();
    final data = await _arenasProvider.getArenaByUserId(
      ownerId: _preferences.getUserId(),
    );
    arenas.addAll(data);
    if (arenas.isNotEmpty) {
      selectedArena.value = arenas.first;
    }
  }

  Future<void> getFieldByArena({int? arenaId}) async {
    fields.clear();

    final idToUse = arenaId ?? arenas.firstOrNull?.id;
    if (idToUse == null) return;

    final data = await _fieldsProvider.getFieldByArenaId(arenaId: idToUse);
    fields.addAll(data);

    if (fields.isNotEmpty) {
      selectedField.value = fields.first;
    }
  }

  Future<void> updateArenaSelected(Arena arena) async {
    selectedArena.value = arena;
    update();
    await getFieldByArena(arenaId: arena.id);
    await _loadReservationsForField(selectedField.value, today.value);
  }

  void updateFieldSelected(Field field) {
    selectedField.value = field;
    update();
    _loadReservationsForField(field, today.value);
  }

  void _initializeReservations({int? fieldOrder}) {
    reservations.assignAll(
      List.generate(
        24,
        (i) => Reservation(
          timeSlot: i,
          fieldId: fieldOrder ?? fields.firstOrNull?.order,
          reservationStatus: "disable",
        ),
      ),
    );
  }

  Future<void> _loadReservationsForField(Field field, DateTime date) async {
    updateLoadData(false);
    _initializeReservations(fieldOrder: field.order ?? 0);

    final data = await _reservationsProvider.getReservationsByFieldsIdByDay(
      fieldId: field.id ?? 0,
      actualDay: date,
    );

    for (final real in data) {
      final index = reservations.indexWhere((r) => r.timeSlot == real.timeSlot);
      if (index != -1) reservations[index] = real;
    }

    updateLoadData(true);
  }

  void increaseDay() {
    today.value = today.value.add(const Duration(days: 1));
    _loadReservationsForField(selectedField.value, today.value);
  }

  void decreaseDay() {
    today.value = today.value.subtract(const Duration(days: 1));
    _loadReservationsForField(selectedField.value, today.value);
  }

  void resetDay() {
    Get.back();
    today.value = dynamicDay.value;
    _loadReservationsForField(selectedField.value, today.value);
  }

  String formatHour(int hour24) {
    final hour12 = hour24 % 12 == 0 ? 12 : hour24 % 12;
    final period = hour24 < 12 ? 'AM' : 'PM';
    return '$hour12:00 $period';
  }

  void updateLoadData(bool value) {
    isLoadData.value = value;
    update();
  }

  Future<void> updateReservationStatus(Reservation reservation) async {}
}
