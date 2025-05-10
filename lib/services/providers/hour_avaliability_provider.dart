import 'package:bukeet/services/models/hour_avaliability.dart' as app;
import 'package:bukeet/services/tables/tables.dart';
import 'package:bukeet/utils/global/log_error_utils.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HourAvailabilityProvider {
  final _supabase = Supabase.instance.client;

  Future<List<app.HourAvailability>> fetchAvailability(int fieldId) async {
    try {
      final data = await _supabase
          .from(Tables.hourAvailability)
          .select()
          .eq('fieldId', fieldId);

      return data.map<app.HourAvailability>((item) {
        return app.HourAvailability.fromJson(item);
      }).toList();
    } catch (exception, stackTrace) {
      LogError.capture(exception, stackTrace, 'fetchAvailability');
      return [];
    }
  }

  Future<bool> checkAvailabilityExists(int fieldId) async {
    try {
      final result = await _supabase
          .from(Tables.hourAvailability)
          .select()
          .eq('fieldId', fieldId)
          .limit(1)
          .maybeSingle();

      return result != null;
    } catch (exception, stackTrace) {
      LogError.capture(exception, stackTrace, 'checkAvailabilityExists');
      return false;
    }
  }

  Future<void> initializeAvailability(int fieldId) async {
    final batch = <Map<String, dynamic>>[];
    final defaultState = List<bool>.filled(24, false);
    final defaultPrices = List<int?>.filled(24, 0);

    for (var day in [
      'monday',
      'tuesday',
      'wednesday',
      'thursday',
      'friday',
      'saturday',
      'sunday'
    ]) {
      batch.add({
        'fieldId': fieldId,
        'day': day,
        'arrayState': defaultState,
        'arrayPrice': defaultPrices,
      });
    }

    await _supabase.from(Tables.hourAvailability).insert(batch);
  }

  Future<bool> updateAvailability({
    required app.HourAvailability hourAvailability,
  }) async {
    try {
      await _supabase
          .from(Tables.hourAvailability)
          .update({
            'arrayState': hourAvailability.arrayState,
            'arrayPrice': hourAvailability.arrayPrice,
          })
          .eq('fieldId', hourAvailability.fieldId!)
          .eq('day', hourAvailability.day!);

      return true;
    } catch (exception, stackTrace) {
      LogError.capture(exception, stackTrace, 'updateAvailability');
      return false;
    }
  }
}
