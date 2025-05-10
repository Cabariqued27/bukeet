import 'package:bukeet/flows/authentication/routes/authentication_routes.dart';
import 'package:get/get.dart';

class AuthenticationFlow extends GetxController {
  void start() {
    Get.offAllNamed(AuthenticationRoutes().auth);
    return;
  }

  void validate() {
    Get.toNamed(AuthenticationRoutes().validateAuth);
    return;
  }

  void resetPassword() {
    Get.toNamed(AuthenticationRoutes().resetPassword);
    return;
  }
}
