
import 'package:bukeet/services/providers/user_provider.dart';
import 'package:bukeet/utils/global/log_error_utils.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthProvider {
  final _supabase = Supabase.instance.client;
  final _userProvider = UserProvider();

  Future<String?> updateUser({
    required String email,
    required String password,
  }) async {
    try {
      var isUpdated = await _supabase.auth.updateUser(
        UserAttributes(
          password: password,
          email: email.toLowerCase(),
        ),
      );

      if (isUpdated.user != null) {
        return isUpdated.user?.id ?? '';
      }
    } catch (exception, stackTrace) {
      LogError.capture(exception, stackTrace, 'registerAuthUser');
    }

    return null;
  }

  Future<AuthResponse?> signIn({
    required String email,
    required String password,
  }) async {
    try {
      var data = await _supabase.auth.signInWithPassword(
        email: email.toLowerCase(),
        password: password,
      );
      return data;
    } catch (exception, stackTrace) {
      LogError.capture(exception, stackTrace, 'signIn');
      return null;
    }
  }

  Future<bool> checkEmailExists({
    required String email,
  }) async {
    var user = await _userProvider.getUserByEmail(
      email: email.toLowerCase(),
    );

    if (user != null) {
      return true;
    }

    return false;
  }

  Future<bool> canlogin({
    required String email,
  }) async {
    var user = await _userProvider.getUserByEmail(
      email: email.toLowerCase(),
    );

    if (user != null) {
      var validatedEmail = user.validatedEmail ?? false;
      var hasPassword = user.hasPassword ?? false;

      var canLogin = (validatedEmail && hasPassword) ? true : false;

      return canLogin;
    }

    return false;
  }

  Future<bool> canSignUp({
    required String email,
  }) async {
    var user = await _userProvider.getUserByEmail(
      email: email.toLowerCase(),
    );

    if (user != null) {
      var validatedEmail = user.validatedEmail ?? false;
      var hasPassword = user.hasPassword ?? false;

      var canSignUp = (validatedEmail && hasPassword) ? false : true;

      return canSignUp;
    }

    return true;
  }

  Future<UserResponse?> updatePassword({
    required String password,
  }) async {
    try {
      var data = await _supabase.auth.updateUser(
        UserAttributes(
          password: password,
        ),
      );
      return data;
    } catch (exception, stackTrace) {
      LogError.capture(exception, stackTrace, 'updatePassword');
      return null;
    }
  }

  Future<bool> requestOtp({
    required String email,
  }) async {
    try {
      await _supabase.auth.signInWithOtp(
        shouldCreateUser: true,
        email: email.toLowerCase(),
      );
      return true;
    } catch (exception, stackTrace) {
      LogError.capture(exception, stackTrace, 'requestOtp');
      return false;
    }
  }

  Future<bool> requestOtpForResetPassword({
    required String email,
  }) async {
    try {
      await _supabase.auth.resetPasswordForEmail(
        email.toLowerCase(),
      );
      return true;
    } catch (exception, stackTrace) {
      LogError.capture(exception, stackTrace, 'requestOtpForResetPassword');
      return false;
    }
  }

  Future<bool> validateOtp({
    required String email,
    required String code,
  }) async {
    try {
      await _supabase.auth.verifyOTP(
        type: OtpType.email,
        token: code,
        email: email.toLowerCase(),
      );
      return true;
    } catch (exception, stackTrace) {
      LogError.capture(exception, stackTrace, 'validateOtp');
      return false;
    }
  }

  Future<bool> validateOtpForRecoverPassword({
    required String email,
    required String code,
  }) async {
    try {
      await _supabase.auth.verifyOTP(
        type: OtpType.recovery,
        token: code,
        email: email.toLowerCase(),
      );
      return true;
    } catch (exception, stackTrace) {
      LogError.capture(exception, stackTrace, 'validateOtpForRecoverPassword');
      return false;
    }
  }

  Future<void> signOut() async {
    try {
      await _supabase.auth.signOut();
    } catch (exception, stackTrace) {
      LogError.capture(exception, stackTrace, 'signOut');
    }
  }

  Session? getCurrentUser() {
    var session = _supabase.auth.currentSession;
    return session;
  }

  Future<bool> updateProfileByEmail({
    required String firstName,
    required String lastName,
  }) async {
    try {
      await _supabase.auth.updateUser(
        UserAttributes(
          data: {
            'firstName': firstName,
            'lastName': lastName,
          },
        ),
      );

      return true;
    } catch (exception, stackTrace) {
      LogError.capture(exception, stackTrace, 'updateProfileByEmail');
      return false;
    }
  }

  Future<bool> updateAuthEmail({
    required String email,
  }) async {
    try {
      await _supabase.auth.updateUser(
        UserAttributes(
          data: {
            'email': email.toLowerCase(),
          },
        ),
      );

      return true;
    } catch (exception, stackTrace) {
      LogError.capture(exception, stackTrace, 'updateEmail');
      return false;
    }
  }

  Future<bool> resetPassword({
    required String email,
  }) async {
    try {
      await _supabase.auth.resetPasswordForEmail(
        email.toLowerCase(),
      );
      return true;
    } catch (exception, stackTrace) {
      LogError.capture(exception, stackTrace, 'updateEmail');
      return false;
    }
  }
}
