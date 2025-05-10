import 'package:bukeet/flows/fieldOwner/home/pages/home_field_owner_page_flow.dart';
import 'package:get/get.dart';

class HomeFieldOwnerRoutes {
  
  String fieldOwnerHome = '/fieldownerHome';

  List<GetPage<dynamic>> routes() {
    return [
      
      GetPage(
        name: fieldOwnerHome,
        page: () => const HomeFieldOwnerPageFlow(),
      ),
      
    ];
  }
}
