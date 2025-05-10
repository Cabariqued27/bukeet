import 'package:bukeet/flows/authentication/pages/authentication_page_flow.dart';
import 'package:bukeet/flows/authentication/pages/reset_password_page_flow.dart';
import 'package:bukeet/flows/authentication/pages/validate_auth_page_flow.dart';
import 'package:get/get.dart';

class AuthenticationRoutes {
  String auth = '/auth';
  String validateAuth = '/validateAuth';
  String resetPassword = '/resetPassword';

  List<GetPage<dynamic>> routes() {
    return [
      GetPage(
        name: auth,
        page: () => const AuthenticationPageFlow(),
      ),
      GetPage(
        name: validateAuth,
        page: () => const ValidateAuthPageFlow(),
      ),
      GetPage(
        name: resetPassword,
        page: () => const ResetPasswordPageFlow(),
      ),
    ];
  }
}
