import 'package:blood_donation/navigation_menu.dart';
import 'package:get/get.dart';

import '../../../data/model/home_option.dart';

class HomeController extends GetxController {
  static HomeController get instance => Get.find();

  List<HomeOption> homeOption = [
    HomeOption(
      optionName: 'Donor',
      iconUrl: 'assets/image/donors.png',
      function: () {
        final NavigationMenuController controller =
            Get.find<NavigationMenuController>();
        controller.selectedIndex.value = 1;
      },
    ),
    HomeOption(
      optionName: 'Bank',
      iconUrl: 'assets/image/donation.png',
      function: () {},
    ),
    HomeOption(
      optionName: 'Hospital',
      iconUrl: 'assets/image/medicine.png',
      function: () {},
    ),
    HomeOption(
      optionName: 'Request',
      iconUrl: 'assets/image/blood-bag.png',
      function: () {},
    ),
    HomeOption(
      optionName: 'Organization',
      iconUrl: 'assets/image/partners.png',
      function: () {},
    ),
  ];
}
