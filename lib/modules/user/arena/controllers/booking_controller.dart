import 'dart:convert';
import 'package:bukeet/secrets.dart';
import 'package:http/http.dart' as http;
import 'package:bukeet/preferences/user_preferences.dart';
import 'package:bukeet/services/models/arena.dart';
import 'package:bukeet/services/models/field.dart';
import 'package:bukeet/services/models/hour_avaliability.dart';
import 'package:bukeet/services/models/reservation.dart';
import 'package:bukeet/services/providers/hour_avaliability_provider.dart';
import 'package:bukeet/services/providers/reservation_provider.dart';
import 'package:bukeet/theme/theme.dart';
import 'package:bukeet/utils/alerts/alerts_utils.dart';
import 'package:bukeet/utils/global/date_parse_utils.dart';
import 'package:bukeet/utils/global/log_error_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
//import 'package:payu_checkoutpro_flutter/payu_checkoutpro_flutter.dart';

class BookingController extends GetxController {
  final VoidCallback onNext;
  final VoidCallback onBack;
  final AppTheme theme;
  final Field? fieldInformation;
  final Arena? arenaInformation;

  BookingController({
    required this.onNext,
    required this.onBack,
    required this.theme,
    this.fieldInformation,
    this.arenaInformation,
  });

  //late PayUCheckoutProFlutter checkoutPro;

  var reservations = <Reservation>[].obs;
  var listAvailableTimes = <int>[].obs;
  var listPriceAvailableTimes = <int>[].obs;
  var selectedHour = 100.obs;
  var selectedHourPrice = 0.obs;
  var isLoadData = false.obs;
  var activateNext = false.obs;
  var isLoadDataReservations = false.obs;
  var hourAvailability = <String, HourAvailability>{}.obs;

  int reservationDuration = 1;
  var today = DateTime.now().obs;
  var todayDynamic = DateTime.now().obs;
  final dateController = TextEditingController();

  final _fieldsProvider = ReservationProvider();
  final _hourAvailabilityProvider = HourAvailabilityProvider();
  final _preferences = UserPreferences();

  Future<void> startController() async {
    //checkoutPro = PayUCheckoutProFlutter();
    final selectedDate = _getOnlyDate(today.value);
    reservations.value = await _fieldsProvider.getReservedTimes(
      fieldId: fieldInformation?.id ?? 0,
      selectedDate: selectedDate,
    );
    await initializeAvailabilityIfNeeded(fieldInformation?.id ?? 0);
    updateLoadData(true);
    getAvailableTimes();
  }

  Future<void> getAvaliablesTimes() async {
    reservations.clear();
    final selectedDate = _getOnlyDate(todayDynamic.value);
    reservations.value = await _fieldsProvider.getReservedTimes(
      fieldId: fieldInformation?.id ?? 0,
      selectedDate: selectedDate,
    );
    updateLoadData(true);
    getAvailableTimes();
  }

  void onChangeForm() {
    if (selectedHour.value != 100) {
      updateActivateNext(true);
    }
  }

  void updateActivateNext(bool value) => activateNext.value = value;

  void updateLoadData(bool value) => isLoadData.value = value;

  void updateLoadDataReservations(bool value) =>
      isLoadDataReservations.value = value;

  List<int> getAvailableTimes() {
    listAvailableTimes.clear();
    listPriceAvailableTimes.clear();

    final isToday = _isSameDay(today.value, todayDynamic.value);
    final dayOfWeek =
        DateFormat('EEEE').format(todayDynamic.value).toLowerCase();
    final availability = hourAvailability[dayOfWeek];

    for (int hour = 0; hour < 24; hour++) {
      final timeSlot = hour;

      final isReserved = reservations.any((res) {
        try {
          return res.timeSlot == timeSlot;
        } catch (e, s) {
          LogError.capture(e, s, 'getReservedTimes');
          return false;
        }
      });

      final isAvailable = availability?.arrayState?[hour] ?? true;

      if (!isReserved && isAvailable && (!isToday || today.value.hour < hour)) {
        listAvailableTimes.add(timeSlot);
        listPriceAvailableTimes.add(availability?.arrayPrice?[hour]);
      }
    }
    update();

    updateLoadDataReservations(true);
    return List<int>.from(listAvailableTimes);
  }

  void setSelectedHour(int value) {
    selectedHour.value = value;

    onChangeForm();
  }

  void setSelectedPrice(int value) {
    selectedHourPrice.value = value;
    onChangeForm();
  }

  Future<void> createReservation() async {
    final newReservation = Reservation(
      userId: _preferences.getUserId(),
      fieldId: fieldInformation?.id ?? 0,
      date: todayDynamic.value,
      timeSlot: selectedHour.value,
      updateAt: today.value,
      status: false,
      totalPrice: selectedHourPrice.value,
    );

    try {
      final data =
          await _fieldsProvider.createReservationByUserId(data: newReservation);
      if (data != null) {
        AlertUtils.showMessageAlert(
          title: 'reservation_success'.tr,
          buttonTitle: 'close'.tr,
          onPressed: () => Get.back(),
        );
      } else {
        // En caso de que createReservationByUserId devuelva null sin excepción
        AlertUtils.showMessageAlert(
          title: 'reservation_reject'.tr,
          buttonTitle: 'close'.tr,
          onPressed: () => Get.back(),
        );
      }
    } catch (e) {
      // Aquí puedes personalizar según el tipo de error que recibas
      // Por ejemplo, si tienes una clase de error para violación de constraint
      final errorMessage = _parseReservationError(e);
      AlertUtils.showMessageAlert(
        title: errorMessage,
        buttonTitle: 'close'.tr,
        onPressed: () => Get.back(),
      );
    }
  }

  String _parseReservationError(dynamic e) {
    // Aquí detectas el error específico de duplicado
    // El ejemplo es general, adapta según el error real de tu backend o librería HTTP

    final errorString = e.toString().toLowerCase();

    if (errorString.contains('unique constraint') ||
        errorString.contains('duplicate key') ||
        errorString.contains('23505') || // código error PostgreSQL
        errorString.contains('conflict')) {
      return 'Ya existe una reserva para ese campo, fecha y horario.';
    }

    // Otros errores o mensajes por defecto
    return 'reservation_reject'.tr;
  }

  void confirmReservation() {
    AlertUtils.showComnfirmReservationAlert(
      date: DateFormat('yyyy-MM-dd').format(todayDynamic.value),
      hour: selectedHour.value,
      fieldInformation: arenaInformation?.address ?? '',
      price: '\$${selectedHourPrice.value}',
      positiveAction: createReservation,
      negativeAction: () => Get.back(),
      barrierDismissible: false,
    );
  }

  Future<void> chooseDate() async {
    final pickedDate = await showDatePicker(
      context: Get.context!,
      initialDate: todayDynamic.value,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 60)),
      helpText: 'Select DOB',
      cancelText: 'Close',
      confirmText: 'Confirm',
      errorFormatText: 'Enter valid date',
      errorInvalidText: 'Enter valid date range',
      fieldLabelText: 'DOB',
      fieldHintText: 'Month/Date/Year',
      selectableDayPredicate: disableDate,
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      initialDatePickerMode: DatePickerMode.day,
    );

    if (pickedDate != null) {
      final date = DateParseUtils.decodeDate(pickedDate.toString());
      dateController.text = date.toString();
      todayDynamic.value = pickedDate;
      getAvaliablesTimes();
    }
  }

  bool disableDate(DateTime day) {
    final todayDate = _getOnlyDate(DateTime.now());
    final lastAvailableDate = todayDate.add(const Duration(days: 60));
    return day.isAfter(todayDate.subtract(const Duration(days: 1))) &&
        day.isBefore(lastAvailableDate.add(const Duration(days: 1)));
  }

  Future<void> initializeAvailabilityIfNeeded(int fieldId) async {
    final fetchedAvailability =
        await _hourAvailabilityProvider.fetchAvailability(fieldId);
    hourAvailability.value = {
      for (var item in fetchedAvailability)
        if (item.day != null) item.day!: item
    };
  }

  DateTime _getOnlyDate(DateTime date) =>
      DateTime(date.year, date.month, date.day);

  bool _isSameDay(DateTime d1, DateTime d2) =>
      d1.year == d2.year && d1.month == d2.month && d1.day == d2.day;

  Future<void> crearTransaccionPSE() async {
    final referenciaUnica = generarReferenciaUnica();

    final response = await http.post(
      Uri.parse(
          'https://zwotqlhempawzymqxbne.supabase.co/functions/v1/start-pay-wompi/pse-transaction'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $supabaseAnonKey',
      },
      body: jsonEncode({
        "amount_in_cents": 150000,
        "currency": "COP",
        "customer_email": "usuario@correo.com",
        "user_legal_id": "1999888777",
        "user_legal_id_type": "CC",
        "payment_description": "Pago a Tienda Wompi",
        "reference": referenciaUnica,
        "success_url": "https://tuapp.com/pago_exitoso",
        "financial_institution_code": "1",
        "user_type": 0,
        "phone_number": "3001234567", // Requerido por Wompi
        "full_name": "Juan Pérez", // Requerido por Wompi
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final redirectUrl = data['async_payment_url'];

      if (redirectUrl != null) {
        abrirEnNavegador(redirectUrl);
      } else {
        Get.snackbar('Error', 'No se recibió la URL de redirección.');
      }
    } else {
      Get.snackbar('Error', 'Falló la transacción: ${response.body}');
    }
  }

  Future<void> abrirEnNavegador(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      Get.snackbar('Error', 'No se pudo abrir la URL');
    }
  }

  String generarReferenciaUnica() {
    final now = DateTime.now();
    return 'ref_${now.microsecondsSinceEpoch}';
  }

  String formatHour(int hour24) {
    final int hour12 = hour24 % 12 == 0 ? 12 : hour24 % 12;
    final String period = hour24 < 12 ? 'AM' : 'PM';
    return '$hour12:00 $period';
  }
}
