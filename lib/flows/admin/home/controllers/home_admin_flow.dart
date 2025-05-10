import 'package:bukeet/flows/admin/home/routes/home_admin_routes.dart';
import 'package:get/get.dart';

class HomeAdminFlow extends GetxController {
  int? _initialPage;

  void start({
    int? initialPage,
  }) {
    if (initialPage != null) {
      setInitialPage(initialPage);
    }

    Get.offAllNamed(HomeAdminRoutes().adminhome);
  }

  int? getInitialPage() {
    return _initialPage;
  }

  void setInitialPage(int? value) {
    _initialPage = value;
  }

  void startOffNamed() {
    Get.offNamed(HomeAdminRoutes().adminhome);
    return;
  }
}
