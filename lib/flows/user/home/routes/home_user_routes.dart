import 'package:bukeet/flows/user/home/pages/home_user_page_flow.dart';
import 'package:get/get.dart';

class HomeUserRoutes {
  
  String home = '/home';

  List<GetPage<dynamic>> routes() {
    return [
      
      GetPage(
        name: home,
        page: () => const HomePageFlow(),
      ),
      
    ];
  }
}
