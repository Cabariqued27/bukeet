import 'package:bukeet/services/models/field.dart' as app;
import 'package:bukeet/services/tables/tables.dart';
import 'package:bukeet/utils/global/log_error_utils.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class FieldProvider {
  final _supabase = Supabase.instance.client;

  Future<app.Field?> registerField({required app.Field field}) async {
    try {
      final resp = await _supabase.from(Tables.fields).insert({
        'players': field.players,
        'order': field.order,
        'isVerified': false,
        'arenaId': field.arenaId,
      }).select();

      if (resp.isNotEmpty) {
        var data = app.Field.fromJson(resp.first);
        return data;
      }
    } catch (exception, stackTrace) {
      LogError.capture(exception, stackTrace, 'registerDbField');
    }

    return null;
  }

  Future<List<app.Field>> getFields() async {
    try {
      var list = <app.Field>[];
      final data = await _supabase
          .from(Tables.fields)
          .select()
          .eq('isVerified', true);

      for (Map<String, dynamic> item in data) {
        var type = app.Field.fromJson(item);

        list.add(type);
      }

      return list;
    } catch (exception, stackTrace) {
      LogError.capture(exception, stackTrace, 'getFields');
    }

    return [];
  }

  Future<List<app.Field>> getFieldsWithOutVerification() async {
    try {
      var list = <app.Field>[];
      final data = await _supabase
          .from(Tables.fields)
          .select()
          .eq('isVerified', false);

      for (Map<String, dynamic> item in data) {
        var type = app.Field.fromJson(item);

        list.add(type);
      }

      return list;
    } catch (exception, stackTrace) {
      LogError.capture(exception, stackTrace, 'getFieldsWithOutVerification');
    }

    return [];
  }

  Future<List<app.Field>> getFieldById({required int id}) async {
    try {
      var list = <app.Field>[];
      final data = await _supabase.from(Tables.fields).select().eq('id', id);

      for (Map<String, dynamic> item in data) {
        var type = app.Field.fromJson(item);

        list.add(type);
      }

      return list;
    } catch (exception, stackTrace) {
      LogError.capture(exception, stackTrace, 'getFieldById');
    }

    return [];
  }

  Future<List<app.Field>> getFieldByArenaId({required int arenaId}) async {
    try {
      var list = <app.Field>[];
      final data = await _supabase
          .from(Tables.fields)
          .select()
          .eq('arenaId', arenaId)
          .order('order', ascending: true);

      for (Map<String, dynamic> item in data) {
        var type = app.Field.fromJson(item);

        list.add(type);
      }

      return list;
    } catch (exception, stackTrace) {
      LogError.capture(exception, stackTrace, 'getFieldByArenaId');
    }

    return [];
  }

  Future<bool> uploadFieldsImagesList({
    required int id,
    required List<String> imageUrls,
  }) async {
    try {
      await _supabase
          .from(Tables.fields)
          .update({'images': imageUrls})
          .eq('id', id);
      return true;
    } catch (exception, stackTrace) {
      LogError.capture(exception, stackTrace, 'updateUserImagesList');
      return false;
    }
  }
}
