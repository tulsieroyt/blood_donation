import 'package:blood_donation/src/common/widget/app_bar.dart';
import 'package:blood_donation/src/features/donation/presentation/controller/home/banner_controller.dart';
import 'package:blood_donation/src/features/donation/presentation/controller/home/home_controller.dart';
import 'package:blood_donation/src/features/donation/presentation/controller/request_blood_controller.dart';
import 'package:blood_donation/src/features/donation/presentation/screen/request_blood/request_details_screen.dart';
import 'package:blood_donation/src/features/donation/presentation/widget/banner_cauresol.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final homeController = Get.put(HomeController());
  final requestController = Get.put(RequestBloodController());
  final bannerController = Get.put(BannerController());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BDAppBar(title: 'Home'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const SizedBox(height: 16),
              const BannerCarousel(
                height: 200,
              ),
              const SizedBox(height: 16),
              GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: homeController.homeOption.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                  childAspectRatio: .9,
                ),
                itemBuilder: (BuildContext context, int index) {
                  final homeOption = homeController.homeOption[index];
                  return GestureDetector(
                    onTap: () => homeOption.function(),
                    child: Container(
                      height: double.infinity,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.redAccent,
                            blurRadius: 2.0,
                            spreadRadius: 0.0,
                            offset: Offset(0.0, 0.0),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                              height: 50,
                              width: 50,
                              child: Image.asset(
                                homeOption.iconUrl,
                              )),
                          const SizedBox(height: 8),
                          Text(
                            homeOption.optionName,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 24),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Donation Request',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Icon(Icons.arrow_forward)
                ],
              ),
              const SizedBox(height: 8),
              Obx(
                () => requestController.userRequests.isEmpty
                    ? const SizedBox(
                        height: 100,
                        child: Center(
                          child: Text('No Request found!'),
                        ),
                      )
                    : ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: requestController.userRequests.length,
                        separatorBuilder: (_, __) => Container(
                          height: 10,
                        ),
                        itemBuilder: (context, index) {
                          final request = requestController.userRequests[index];
                          return GestureDetector(
                            onTap: () => Get.to(
                                RequestDetailsScreen(userRequest: request)),
                            child: Container(
                              width: double.infinity,
                              height: 120,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.redAccent,
                                    blurRadius: 2.0,
                                    spreadRadius: 0.0,
                                    offset: Offset(0.0, 0.0),
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      height: 100,
                                      width: 100,
                                      decoration: const BoxDecoration(
                                          color: Colors.white),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child:
                                            request.user.profilePicture.isEmpty
                                                ? Image.asset(
                                                    'assets/image/default-image.png',
                                                    fit: BoxFit.fill,
                                                  )
                                                : Image.network(
                                                    request.user.profilePicture,
                                                    fit: BoxFit.fill,
                                                  ),
                                      ),
                                    ),
                                    const SizedBox(width: 4),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              const Icon(
                                                Icons.person,
                                                color: Colors.redAccent,
                                                size: 16,
                                              ),
                                              Flexible(
                                                child: Text(
                                                  '${request.user.firstName} ${request.user.lastName}',
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.black87,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  softWrap: false,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Icon(
                                                Icons.location_pin,
                                                color: Colors.redAccent,
                                                size: 16,
                                              ),
                                              Flexible(
                                                child: Text(
                                                  request.user.location,
                                                  style: const TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.black54,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  softWrap: false,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Icon(
                                                Icons.watch_later_outlined,
                                                color: Colors.redAccent,
                                                size: 16,
                                              ),
                                              Flexible(
                                                child: Text(
                                                  '2 hours ago',
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.black54,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  softWrap: false,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          request.request.bloodType,
                                          style: const TextStyle(
                                            color: Colors.redAccent,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const Icon(
                                          Icons.bloodtype,
                                          color: Colors.redAccent,
                                          size: 28,
                                        ),
                                        const Text(
                                          'Donate',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color: Colors.redAccent,
                                            fontSize: 17,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
              ),
              const SizedBox(height: 16)
            ],
          ),
        ),
      ),
    );
  }
}
