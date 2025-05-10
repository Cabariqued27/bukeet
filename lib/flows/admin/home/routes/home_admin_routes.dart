import 'package:bukeet/flows/admin/home/pages/home_admin_page_flow.dart';
import 'package:get/get.dart';

class HomeAdminRoutes {
  
  String adminhome = '/adminhome';

  List<GetPage<dynamic>> routes() {
    return [
      
      GetPage(
        name: adminhome,
        page: () => const HomeAdminPageFlow(),
      ),
      
    ];
  }
}
