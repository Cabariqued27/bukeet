import 'package:bukeet/flows/user/arena/pages/booking_page_flow.dart';
import 'package:bukeet/flows/user/arena/pages/fields_user_page_flow.dart';
import 'package:get/get.dart';

class ArenaUserRoutes {
  String booking = '/booking';
  String userFields = '/userFields';

  List<GetPage<dynamic>> routes() {
    return [
      GetPage(
        name: booking,
        page: () => const BookingPageFlow(),
      ),
      GetPage(
        name: userFields,
        page: () => const FieldsPageFlow(),
      ),
    ];
  }
}
