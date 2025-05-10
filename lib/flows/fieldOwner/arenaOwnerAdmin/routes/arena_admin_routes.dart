
import 'package:bukeet/flows/fieldOwner/arenaOwnerAdmin/pages/create_arena_admin_page_flow.dart';
import 'package:get/get.dart';

class ArenaAdminRoutes {
  String createArenaAdmin = '/createArenaAdmin';
 

  List<GetPage<dynamic>> routes() {
    return [
      GetPage(
        name: createArenaAdmin,
        page: () => const CreateArenaAdminPageFlow(),
      ),
    ];
  }
}
