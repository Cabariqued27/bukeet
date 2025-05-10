import 'package:bukeet/flows/fieldOwner/home/routes/home_field_owner_routes.dart';
import 'package:get/get.dart';

class HomeFieldOwnerFlow extends GetxController {
  int? _initialPage;

  void start({
    int? initialPage,
  }) {
    if (initialPage != null) {
      setInitialPage(initialPage);
    }

    Get.offAllNamed(HomeFieldOwnerRoutes().fieldOwnerHome);
  }

  int? getInitialPage() {
    return _initialPage;
  }

  void setInitialPage(int? value) {
    _initialPage = value;
  }

  void startOffNamed() {
    Get.offNamed(HomeFieldOwnerRoutes().fieldOwnerHome);
    return;
  }
}
