import 'package:bukeet/services/models/reservation.dart' as app;
import 'package:bukeet/services/tables/tables.dart';
import 'package:bukeet/utils/global/log_error_utils.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ReservationProvider {
  final _supabase = Supabase.instance.client;

  Future<List<app.Reservation>> getReservedTimes({
    required int fieldId,
    required DateTime selectedDate,
  }) async {
    try {
      var list = <app.Reservation>[];
      final data = await _supabase
          .from(Tables.reservations)
          .select()
          .eq('fieldId', fieldId)
          .eq('date', selectedDate);
      for (Map<String, dynamic> item in data) {
        var type = app.Reservation.fromJson(item);
        list.add(type);
      }

      return list;
    } catch (exception, stackTrace) {
      LogError.capture(exception, stackTrace, 'getReservedTimes');
    }
    return [];
  }

  Future<app.Reservation?> createReservationByUserId({
    required app.Reservation data,
  }) async {
    try {
      var resp = await _supabase.from(Tables.reservations).insert({
        'userId': data.userId,
        'fieldId': data.fieldId,
        'date': data.date?.toIso8601String(),
        'timeSlot': data.timeSlot,
        'updated_at': data.updateAt?.toIso8601String(),
        'paymentStatus': data.paymentStatus,
        'totalPrice': data.totalPrice,
        'reference': data.reference,
      }).select();

      if (resp.isNotEmpty) {
        var data = app.Reservation.fromJson(resp.first);
        return data;
      }
    } catch (exception, stackTrace) {
      LogError.capture(exception, stackTrace, 'createReservation');
    }

    return null;
  }

  Future<List<app.Reservation>> getReservationsById({
    required int userId,
  }) async {
    try {
      var list = <app.Reservation>[];
      final data = await _supabase
          .from(Tables.reservations)
          .select()
          .eq('userId', userId)
          .order('date', ascending: false);
      for (Map<String, dynamic> item in data) {
        var type = app.Reservation.fromJson(item);
        list.add(type);
      }

      return list;
    } catch (exception, stackTrace) {
      LogError.capture(exception, stackTrace, 'getReservationsById');
    }
    return [];
  }

  Future<List<app.Reservation>> getReservationsByFieldsId({
    required int fieldId,
  }) async {
    try {
      var list = <app.Reservation>[];
      final data = await _supabase
          .from(Tables.reservations)
          .select()
          .eq('fieldId', fieldId);
      for (Map<String, dynamic> item in data) {
        var type = app.Reservation.fromJson(item);
        list.add(type);
      }

      return list;
    } catch (exception, stackTrace) {
      LogError.capture(exception, stackTrace, 'getReservationsByFieldsId');
    }
    return [];
  }

  /*Future<bool> updateReservationStatus({
    required app.UpdateReservation updateReservation,
  }) async {
    try {
      await _supabase
          .from(Tables.reservations)
          .update({'status': updateReservation.status})
          .eq('id', updateReservation.id);
      return true;
    } catch (exception, stackTrace) {
      LogError.capture(exception, stackTrace, 'updateUserDataByEmail');
      return false;
    }
  }*/

  Future<bool> updateReservationByReference({
    required app.UpdateReservation updateReservation,
  }) async {
    try {
      await _supabase
          .from(Tables.reservations)
          .update({
            'paymentStatus': updateReservation..paymentStatus,
            'reservationStatus': updateReservation..reservationStatus,
          })
          .eq('id', updateReservation.id);
      return true;
    } catch (exception, stackTrace) {
      LogError.capture(exception, stackTrace, 'updateUserDataByEmail');
      return false;
    }
  }
}
