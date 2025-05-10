import 'package:bukeet/flows/admin/home/controllers/home_admin_flow.dart';
import 'package:bukeet/flows/authentication/controllers/authentication_flow.dart';
import 'package:bukeet/flows/fieldOwner/arenaOwnerAdmin/controllers/arena_owner_admin_flow.dart';
import 'package:bukeet/flows/fieldOwner/fieldOwnerAdmin/controllers/field_owner_admin_flow.dart';
import 'package:bukeet/flows/fieldOwner/home/controllers/home_field_owner_flow.dart';
import 'package:bukeet/flows/user/arena/controllers/arena_user_flow.dart';
import 'package:bukeet/flows/user/home/controllers/home_admin_flow.dart';
import 'package:bukeet/theme/theme.dart';
import 'package:get/get.dart';

class InitialBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(
      AppTheme(),
      permanent: true,
    );
    Get.put(
      AuthenticationFlow(),
      permanent: true,
    );
    Get.put(
      HomeUserFlow(),
      permanent: true,
    );
    Get.put(
      ArenaUserFlow(),
      permanent: true,
    );
    Get.put(
      HomeAdminFlow(),
      permanent: true,
    );
    Get.put(
      FieldOwnerAdminFlow(),
      permanent: true,
    );
    Get.put(
      ArenaOwnerAdminFlow(),
      permanent: true,
    );
    Get.put(
      HomeFieldOwnerFlow(),
      permanent: true,
    );
  }
}
