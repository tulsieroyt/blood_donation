import 'package:blood_donation/src/common/widget/app_bar.dart';
import 'package:blood_donation/src/features/personalization/presentation/controller/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BDAppBar(title: 'Profile'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: double.infinity,
                height: 300,
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    Stack(
                      children: [
                        Center(
                          child: InkWell(
                            onTap: () =>
                                profileController.uploadProfilePicture(),
                            child: Container(
                              height: 120,
                              width: 120,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: Colors.blue,
                              ),
                              child: Obx(() => Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(100),
                                      child: profileController.userInfo.value
                                              .profilePicture.isEmpty
                                          ? Image.asset(
                                              'assets/image/default-image.png',
                                              fit: BoxFit.fill,
                                            )
                                          : Image.network(
                                              profileController.userInfo.value
                                                  .profilePicture,
                                              fit: BoxFit.fill,
                                            ),
                                    ),
                                  )),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Obx(
                      () => Text(
                        '${profileController.userInfo.value.firstName} ${profileController.userInfo.value.lastName}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Obx(
                      () => Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.location_pin,
                            color: Colors.redAccent,
                            size: 20,
                          ),
                          Text(
                            profileController.userInfo.value.location,
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w800,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                            onPressed: () {},
                            child: const Row(
                              children: [
                                SizedBox(width: 4),
                                Icon(
                                  Icons.call,
                                  color: Colors.white,
                                ),
                                SizedBox(width: 8),
                                Text('Call Now'),
                                SizedBox(width: 4),
                              ],
                            )),
                        ElevatedButton(
                          onPressed: () {},
                          child: const Row(
                            children: [
                              SizedBox(width: 4),
                              Icon(
                                Icons.share,
                                color: Colors.white,
                              ),
                              SizedBox(width: 8),
                              Text('Request'),
                              SizedBox(width: 4),
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: profileController.profileOption.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                    childAspectRatio: .9),
                itemBuilder: (BuildContext context, int index) {
                  final option = profileController.profileOption[index];
                  return Container(
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
                        Text(
                          option.value,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.redAccent,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          option.title,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(height: 16),
              const Text(
                'Last Donation:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              Container(
                width: double.infinity,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.redAccent,
                      blurRadius: 2.0,
                      spreadRadius: 0.0,
                      offset: Offset(0.0, 0.0),
                    ),
                  ],
                ),
                child: const Center(
                  child: Text(
                    'September 1, 2024',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 28,
                        color: Colors.black87),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Donation History:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 10,
                separatorBuilder: (_, __) => Container(height: 10),
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.redAccent,
                          blurRadius: 2.0,
                          spreadRadius: 0.0,
                          offset: Offset(0.0, 0.0),
                        ),
                      ],
                    ),
                    child: ListTile(
                      leading: Text(
                        index.toString(),
                        style: const TextStyle(fontSize: 15),
                      ),
                      title: const Row(
                        children: [
                          Icon(
                            Icons.watch_later_outlined,
                            color: Colors.redAccent,
                            size: 20,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text('September 1, 2024'),
                        ],
                      ),
                      subtitle: const Row(
                        children: [
                          Icon(
                            Icons.location_pin,
                            color: Colors.redAccent,
                            size: 20,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text('Dhaka Medical College, Dhaka'),
                        ],
                      ),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
