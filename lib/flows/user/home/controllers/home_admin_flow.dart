import 'package:bukeet/flows/user/home/routes/home_user_routes.dart';
import 'package:get/get.dart';

class HomeUserFlow extends GetxController {
  int? _initialPage;

  void start({
    int? initialPage,
  }) {
    if (initialPage != null) {
      setInitialPage(initialPage);
    }

    Get.offAllNamed(HomeUserRoutes().home);
  }

  int? getInitialPage() {
    return _initialPage;
  }

  void setInitialPage(int? value) {
    _initialPage = value;
  }

  void startOffNamed() {
    Get.offNamed(HomeUserRoutes().home);
    return;
  }
}
