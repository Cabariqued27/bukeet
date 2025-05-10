import 'package:bukeet/preferences/user_preferences.dart';
import 'package:bukeet/services/providers/auth_provider.dart';
import 'package:bukeet/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ValidateAuthController extends GetxController {
  final VoidCallback onUserHome;
  final VoidCallback onAdminHome;
  final VoidCallback onFieldOwnerHome;
  final VoidCallback onAuth;
  final AppTheme theme;

  ValidateAuthController({
    required this.onUserHome,
    required this.onAdminHome,
    required this.onFieldOwnerHome,
    required this.onAuth,
    required this.theme,
  });

  final _preferences = UserPreferences();

  final _authProvider = AuthProvider();

  void startContoller() async {
    await Future.delayed(const Duration(milliseconds: 1100));
    var currentUser = _authProvider.getCurrentUser();

    if (currentUser != null) {
      var email = currentUser.user.email;
      var isExpiredToken = currentUser.isExpired;

      if (email != null && email.isNotEmpty) {
        var canlogin = await _authProvider.canlogin(email: email);

        if (canlogin && !isExpiredToken) {
          if (_preferences.getUserType() == 'admin') {
            onAdminHome();
          } else if (_preferences.getUserType() == 'Propietario') {
            onFieldOwnerHome();
          } else {
            onUserHome();
          }
          return;
        }
      }
    }

    onAuth();
    return;
  }
}
