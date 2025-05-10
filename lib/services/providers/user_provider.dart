import 'package:bukeet/services/models/user.dart' as app;
import 'package:bukeet/services/tables/tables.dart';
import 'package:bukeet/utils/global/log_error_utils.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserProvider {
  final _supabase = Supabase.instance.client;

  Future<app.User?> registerDbUser({
    required app.User usuario,
  }) async {
    try {
      var user = await getUserByEmail(email: usuario.email.toLowerCase());

      if (user == null) {
        var resp = await _supabase.from(Tables.users).insert(
          {
            'email': usuario.email.toLowerCase(),
            'firstName': usuario.firstName,
            'lastName': usuario.lastName,
            'phoneType': usuario.phoneType,
            'birthDate': usuario.birthDate?.toIso8601String(),
            'gender': usuario.gender,
            'validatedEmail': false,
            'hasPassword': false,
          },
        ).select();

        if (resp.isNotEmpty) {
          var data = app.User.fromJson(resp.first);
          return data;
        }
      }
    } catch (exception, stackTrace) {
      LogError.capture(exception, stackTrace, 'registerDbUser');
    }

    return null;
  }

  Future<bool> updateUserNamesByEmail({
    required app.UpdateUser usuario,
  }) async {
    try {
      await _supabase.from(Tables.users).update(
        {
          'firstName': usuario.firstName,
          'lastName': usuario.lastName,
        },
      ).eq('email', usuario.email.toLowerCase());
      return true;
    } catch (exception, stackTrace) {
      LogError.capture(exception, stackTrace, 'updateUserDataByEmail');
      return false;
    }
  }

  Future<bool> updateUserGenderByEmail({
    required app.UpdateUser usuario,
  }) async {
    try {
      await _supabase.from(Tables.users).update(
        {
          'gender': usuario.gender,
        },
      ).eq('email', usuario.email.toLowerCase());
      return true;
    } catch (exception, stackTrace) {
      LogError.capture(exception, stackTrace, 'updateUserDataByEmail');
      return false;
    }
  }

  Future<bool> updateUserEmail({
    required app.UpdateUser usuario,
    required String actualEmail,
  }) async {
    try {
      await _supabase.from(Tables.users).update(
        {
          'email': usuario.email.toLowerCase(),
        },
      ).eq('email', actualEmail.toLowerCase());
      return true;
    } catch (exception, stackTrace) {
      LogError.capture(exception, stackTrace, 'updateUserEmail');
      return false;
    }
  }

  Future<bool> updateUserImage({
    required String email,
    required String imageUrl,
  }) async {
    try {
      await _supabase.from(Tables.users).update(
        {
          'imageUrl': imageUrl,
        },
      ).eq('email', email.toLowerCase());
      return true;
    } catch (exception, stackTrace) {
      LogError.capture(exception, stackTrace, 'updateUserImage');
      return false;
    }
  }

  Future<bool> updateValidatedEmail({
    required String email,
    required bool value,
  }) async {
    try {
      await _supabase.from(Tables.users).update(
        {
          'validatedEmail': value,
        },
      ).eq('email', email.toLowerCase());
      return true;
    } catch (exception, stackTrace) {
      LogError.capture(exception, stackTrace, 'updateValidatedEmail');
      return false;
    }
  }

  Future<bool> updateValidatedHasPassword({
    required String email,
    required String userUId,
    required bool value,
  }) async {
    try {
      await _supabase.from(Tables.users).update(
        {
          'hasPassword': value,
          'userUId': userUId,
        },
      ).eq('email', email.toLowerCase());
      return true;
    } catch (exception, stackTrace) {
      LogError.capture(exception, stackTrace, 'updateValidatedHasPassword');
      return false;
    }
  }

  Future<app.User?> getUserByEmail({
    required String email,
  }) async {
    try {
      final data = await _supabase
          .from(Tables.users)
          .select()
          .eq('email', email.toLowerCase());

      if (data.isNotEmpty) {
        return app.User.fromJson(data.first);
      }
    } catch (exception, stackTrace) {
      LogError.capture(exception, stackTrace, 'getUserByEmail');
      return null;
    }

    return null;
  }

  Future<bool> setFcmTokenByUser({
    required String email,
    required String fcmToken,
  }) async {
    try {
      await _supabase.from(Tables.users).update(
        {
          'fcmToken': fcmToken,
        },
      ).eq('email', email.toLowerCase());
      return true;
    } catch (exception, stackTrace) {
      LogError.capture(exception, stackTrace, 'setFcmTokenByUser');
      return false;
    }
  }
}
