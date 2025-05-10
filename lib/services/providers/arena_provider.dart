import 'package:bukeet/services/models/arena.dart' as app;
import 'package:bukeet/services/tables/tables.dart';
import 'package:bukeet/utils/global/log_error_utils.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ArenaProvider {
  final _supabase = Supabase.instance.client;

  Future<app.Arena?> registerArena({
    required app.Arena arena,
  }) async {
    try {
      final resp = await _supabase.from(Tables.arena).insert(
        {
          'name': arena.name,
          'city': arena.city,
          'address': arena.address,
          'isVerified': false,
        },
      ).select();

      if (resp.isNotEmpty) {
        var data = app.Arena.fromJson(resp.first);
        return data;
      }
    } catch (exception, stackTrace) {
      LogError.capture(exception, stackTrace, 'registerDbArena');
    }

    return null;
  }

  Future<List<app.Arena>> getArenas() async {
    try {
      var list = <app.Arena>[];
      final data =
          await _supabase.from(Tables.arena).select().eq('isVerified', true);

      for (Map<String, dynamic> item in data) {
        var type = app.Arena.fromJson(item);

        list.add(type);
      }

      return list;
    } catch (exception, stackTrace) {
      LogError.capture(exception, stackTrace, 'getArenas');
    }

    return [];
  }

  Future<List<app.Arena>> getarenaWithOutVerification() async {
    try {
      var list = <app.Arena>[];
      final data =
          await _supabase.from(Tables.arena).select().eq('isVerified', false);

      for (Map<String, dynamic> item in data) {
        var type = app.Arena.fromJson(item);

        list.add(type);
      }

      return list;
    } catch (exception, stackTrace) {
      LogError.capture(exception, stackTrace, 'getarenaWithOutVerification');
    }

    return [];
  }

  Future<List<app.Arena>> getArenaById({required int id}) async {
    try {
      var list = <app.Arena>[];
      final data = await _supabase.from(Tables.arena).select().eq('id', id);

      for (Map<String, dynamic> item in data) {
        var type = app.Arena.fromJson(item);

        list.add(type);
      }

      return list;
    } catch (exception, stackTrace) {
      LogError.capture(exception, stackTrace, 'getArenaById');
    }

    return [];
  }

  Future<List<app.Arena>> getArenaByUserId({required int ownerId}) async {
    try {
      var list = <app.Arena>[];
      final data =
          await _supabase.from(Tables.arena).select().eq('ownerId', ownerId);

      for (Map<String, dynamic> item in data) {
        var type = app.Arena.fromJson(item);

        list.add(type);
      }

      return list;
    } catch (exception, stackTrace) {
      LogError.capture(exception, stackTrace, 'getArenaByUserId');
    }

    return [];
  }

  Future<bool> uploadarenaImagesList({
    required int id,
    required List<String> imageUrls,
  }) async {
    try {
      await _supabase.from(Tables.arena).update(
        {
          'images': imageUrls,
        },
      ).eq('id', id);
      return true;
    } catch (exception, stackTrace) {
      LogError.capture(exception, stackTrace, 'updateUserImagesList');
      return false;
    }
  }
}
