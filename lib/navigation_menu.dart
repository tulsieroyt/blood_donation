import 'package:blood_donation/src/features/donation/presentation/screen/find_donor/find_donor_screen.dart';
import 'package:blood_donation/src/features/donation/presentation/screen/report/report_screen.dart';
import 'package:blood_donation/src/features/personalization/presentation/screen/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'src/features/donation/presentation/screen/home/home_screen.dart';
class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationMenuController());
    return Scaffold(
      bottomNavigationBar: Obx(
            () => NavigationBar(
          height: 60,
          selectedIndex: controller.selectedIndex.value,
          onDestinationSelected: (index) =>
          controller.selectedIndex.value = index,
          backgroundColor: Colors.white,
          indicatorColor:
               Colors.black.withOpacity(0.1),
          destinations: const [
            NavigationDestination(
                icon: Icon(Icons.home), label: 'Home'),
            NavigationDestination(
                icon: Icon(Icons.search), label: 'Find Donors'),
            NavigationDestination(
                icon: Icon(Icons.bloodtype), label: 'Reports'),
            NavigationDestination(
                icon: Icon(Icons.person), label: 'Profile'),
          ],
        ),
      ),
      body: Obx(() => controller.screens[controller.selectedIndex.value]),
    );
  }
}

class NavigationMenuController extends GetxController {
  static NavigationMenuController get instance => Get.find();

  final Rx<int> selectedIndex = 0.obs;
  final screens = [
    const HomeScreen(),
    const FindDonorScreen(),
    const ReportScreen(),
    const ProfileScreen(),
  ];
}
