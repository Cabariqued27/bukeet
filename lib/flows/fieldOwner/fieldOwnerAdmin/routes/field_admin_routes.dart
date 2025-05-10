import 'package:bukeet/flows/fieldOwner/fieldOwnerAdmin/pages/create_field_admin_page_flow.dart';
import 'package:bukeet/flows/fieldOwner/fieldOwnerAdmin/pages/edit_field_admin_page_flow.dart';
import 'package:bukeet/flows/fieldOwner/fieldOwnerAdmin/pages/list_field_admin_page_flow.dart';
import 'package:get/get.dart';

class FieldAdminRoutes {
  String createFieldAdmin = '/createFieldAdmin';
  String listFieldAdmin = '/listFieldAdmin';
  String editFieldAdmin = '/editFieldAdmin';

  List<GetPage<dynamic>> routes() {
    return [
      GetPage(
        name: createFieldAdmin,
        page: () => const CreateFieldAdminPageFlow(),
      ),
      GetPage(
        name: editFieldAdmin,
        page: () => const EditFieldAdminPageFlow(),
      ),
      GetPage(
        name: listFieldAdmin,
        page: () => const ListFieldAdminPageFlow(),
      ),
    ];
  }
}
