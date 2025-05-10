import 'package:bukeet/flows/admin/home/routes/home_admin_routes.dart';
import 'package:bukeet/flows/authentication/routes/authentication_routes.dart';
import 'package:bukeet/flows/fieldOwner/arenaOwnerAdmin/routes/arena_admin_routes.dart';
import 'package:bukeet/flows/fieldOwner/fieldOwnerAdmin/routes/field_admin_routes.dart';
import 'package:bukeet/flows/fieldOwner/home/routes/home_field_owner_routes.dart';
import 'package:bukeet/flows/settings/pages/no_found_page_flow.dart';
import 'package:bukeet/flows/user/arena/routes/arena_user_routes.dart';
import 'package:bukeet/flows/user/home/routes/home_user_routes.dart';
import 'package:get/get.dart';

class Routes {
  List<GetPage<dynamic>>? getRoutes() {
    return [
      ...AuthenticationRoutes().routes(),
      ...HomeUserRoutes().routes(),
      ...ArenaUserRoutes().routes(),
      ...HomeAdminRoutes().routes(),
      ...HomeFieldOwnerRoutes().routes(),
      ...FieldAdminRoutes().routes(),
      ...ArenaAdminRoutes().routes(),
    ];
  }

  getNotFoundPage() {
    String noFound = '/noFound';
    return GetPage(name: noFound, page: () => const NoFoundPageFlow());
  }
}
