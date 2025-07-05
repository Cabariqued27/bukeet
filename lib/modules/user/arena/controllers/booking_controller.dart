import 'dart:convert';
import 'package:bukeet/secrets.dart';
import 'package:bukeet/services/models/institution.dart';
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

  var reservations = <Reservation>[].obs;
  var listAvailableTimes = <int>[].obs;
  var listPriceAvailableTimes = <int>[].obs;
  var listInstitutions = <Institution>[].obs;
  final List<String> peopleTypes = ['Persona Natural', 'Persona Jurídica'];
  final List<String> documentsTypes = ['CC', 'NIT', 'CE'];
  var selectedHour = 100.obs;
  var selectedPeopleType = ''.obs;
  var selectedDocumentType = ''.obs;

  var selectedHourPrice = 0.obs;
  var draggableSize = 0.7.obs;
  var isLoadData = false.obs;
  var activateNext = false.obs;
  var isLoadDataReservations = false.obs;
  var hourAvailability = <String, HourAvailability>{}.obs;

  final fullNameInputController = TextEditingController();
  final customerEmailInputController = TextEditingController();
  final userLegalIdInputController = TextEditingController();
  final phoneNumberInputController = TextEditingController();

  final RxBool hasReachedMax = false.obs;

  var selectedInstitution = Rxn<Institution>();
  var selectedInstitutionName = ''.obs;
  var selectedInstitutionCode = ''.obs;

  int reservationDuration = 1;
  var today = DateTime.now().obs;
  var todayDynamic = DateTime.now().obs;
  final dateController = TextEditingController();

  final _fieldsProvider = ReservationProvider();
  final _hourAvailabilityProvider = HourAvailabilityProvider();
  final _preferences = UserPreferences();

  Future<void> startController() async {
    //checkoutPro = PayUCheckoutProFlutter();
    loadDefaultUserInformation();
    await cargarInstituciones();
    final selectedDate = _getOnlyDate(today.value);
    reservations.value = await _fieldsProvider.getReservedTimes(
      fieldId: fieldInformation?.id ?? 0,
      selectedDate: selectedDate,
    );
    await initializeAvailabilityIfNeeded(fieldInformation?.id ?? 0);
    updateLoadData(true);
    getAvailableTimes();
    //draggableController.addListener(onDraggableScroll);
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

  void loadDefaultUserInformation() {
    fullNameInputController.text =
        "${_preferences.getFirstName()} ${_preferences.getLastName()}";
    customerEmailInputController.text = _preferences.getEmail();
    phoneNumberInputController.text = "${_preferences.getPhoneNumber()}";
    userLegalIdInputController.text = "${_preferences.getDocumentId()}";
    update();
  }

  void onChangeForm() {
    if (selectedHour.value != 100 &&
        customerEmailInputController.text.isNotEmpty &&
        fullNameInputController.text.isNotEmpty &&
        phoneNumberInputController.text.isNum &&
        userLegalIdInputController.text.isNum &&
        selectedInstitutionCode.value.isNotEmpty &&
        selectedPeopleType.value.isNotEmpty &&
        selectedDocumentType.value.isNotEmpty &&
        selectedHourPrice.value != 0) {
      updateActivateNext(true);
    } else {
      updateActivateNext(false);
    }
  }

  void updateActivateNext(bool value) {
    activateNext.value = value;
    update();
  }

  void updateLoadData(bool value) {
    isLoadData.value = value;
    update();
  }

  void updateLoadDataReservations(bool value) {
    isLoadDataReservations.value = value;
    update();
  }

  List<int> getAvailableTimes() {
    listAvailableTimes.clear();
    listPriceAvailableTimes.clear();

    final isToday = _isSameDay(today.value, todayDynamic.value);
    final dayOfWeek = DateFormat(
      'EEEE',
    ).format(todayDynamic.value).toLowerCase();
    final availability = hourAvailability[dayOfWeek];

    for (int hour = 0; hour < 24; hour++) {
      final timeSlot = hour;

      final isReserved = reservations.any((res) {
        try {
          return res.timeSlot == timeSlot && res.reservationStatus == 'enable';
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

  void setSelectedInstitution(Institution value) {
    selectedInstitution.value = value;
    selectedInstitutionName.value = value.nombre;
    selectedInstitutionCode.value = value.codigo;

    onChangeForm();
  }

  void setSelectedPrice(int value) {
    selectedHourPrice.value = value;
    onChangeForm();
  }

  String _parseReservationError(dynamic e) {
    final errorString = e.toString().toLowerCase();

    if (errorString.contains('unique constraint') ||
        errorString.contains('duplicate key') ||
        errorString.contains('23505') ||
        errorString.contains('conflict')) {
      return 'Ya existe una reserva para ese campo, fecha y horario.';
    }

    return 'reservation_reject'.tr;
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
    final fetchedAvailability = await _hourAvailabilityProvider
        .fetchAvailability(fieldId);
    hourAvailability.value = {
      for (var item in fetchedAvailability)
        if (item.day != null) item.day!: item,
    };
  }

  DateTime _getOnlyDate(DateTime date) =>
      DateTime(date.year, date.month, date.day);

  bool _isSameDay(DateTime d1, DateTime d2) =>
      d1.year == d2.year && d1.month == d2.month && d1.day == d2.day;

  void confirmReservation() {
    AlertUtils.showComnfirmReservationAlert(
      date: DateFormat('yyyy-MM-dd').format(todayDynamic.value),
      hour: formatHour(selectedHour.value),
      fieldInformation: arenaInformation?.address ?? '',
      price: '\$${selectedHourPrice.value}',
      positiveAction: createReservation,
      negativeAction: () => Get.back(),
      barrierDismissible: false,
    );
  }

  Future<void> createReservation() async {
    Get.back();

    final referenceGenerated = generarReferenciaUnica();

    final newReservation = Reservation(
      userId: _preferences.getUserId(),
      fieldId: fieldInformation?.id ?? 0,
      date: todayDynamic.value,
      timeSlot: selectedHour.value,
      updateAt: today.value,
      paymentStatus: "PENDING",
      totalPrice: selectedHourPrice.value,
      reference: referenceGenerated,
    );

    try {
      final data = await _fieldsProvider.createReservationByUserId(
        data: newReservation,
      );

      if (data == null) {
        AlertUtils.showMessageAlert(
          title: 'No se pudo crear la reserva',
          buttonTitle: 'Cerrar',
          onPressed: () => Get.back(),
        );
        return;
      }

      final redirectUrl = await crearTransaccionPSE(referenceGenerated);

      if (redirectUrl == null) {
        var updateReservation = UpdateReservation(
          id: data.id ?? 0,
          paymentStatus: "FAILED",
          reservationStatus: "disable",
        );
        await _fieldsProvider.updateReservationByReference(
          updateReservation: updateReservation,
        );

        AlertUtils.showMessageAlert(
          title: 'Error al iniciar la transacción',
          buttonTitle: 'Cerrar',
          onPressed: () => Get.back(),
        );
        return;
      }

      abrirEnNavegador(redirectUrl);
    } catch (e) {
      final errorMessage = _parseReservationError(e);
      AlertUtils.showMessageAlert(
        title: errorMessage,
        buttonTitle: 'Cerrar',
        onPressed: () => Get.back(),
      );
    }
  }

  Future<String?> crearTransaccionPSE(String referenciaUnica) async {
    final response = await http.post(
      Uri.parse('$supabaseUrl/functions/v1/start-pay-wompi/pse-transaction'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $supabaseAnonKey',
      },
      body: jsonEncode({
        "amount_in_cents": selectedHourPrice.value * 10,
        "currency": "COP",
        "customer_email": customerEmailInputController.text,
        "user_legal_id": userLegalIdInputController.text,
        "user_legal_id_type": selectedDocumentType.value,
        "payment_description": "Pago a Tienda Wompi",
        "reference": referenciaUnica,
        "success_url": "https://tuapp.com/pago_exitoso",
        "financial_institution_code": "1",
        "user_type": 0,
        "phone_number": phoneNumberInputController.text,
        "full_name": fullNameInputController.text,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final redirectUrl = data['async_payment_url'];
      return redirectUrl;
    } else {
      Get.snackbar('Error', 'Falló la transacción: ${response.body}');
      return null;
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

  Future<void> cargarInstituciones() async {
    final response = await http.get(
      Uri.parse('https://production.wompi.co/v1/pse/financial_institutions'),
      headers: {
        'Authorization': 'Bearer $wompiKey',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final List institucionesData = jsonData['data'];

      listInstitutions.assignAll(
        institucionesData
            .map<Institution>(
              (institucion) => Institution(
                nombre: institucion['financial_institution_name'],
                codigo: institucion['financial_institution_code'].toString(),
              ),
            )
            .toList(),
      );
    }
  }

  String formatHour(int hour24) {
    final int hour12 = hour24 % 12 == 0 ? 12 : hour24 % 12;
    final String period = hour24 < 12 ? 'AM' : 'PM';
    return '$hour12:00 $period';
  }

  void setSelectedPeopleType(String value) {
    selectedPeopleType.value = value;
    update();
    onChangeForm();
  }

  void setSelectedDocumentType(String value) {
    selectedDocumentType.value = value;
    update();
    onChangeForm();
  }
}
