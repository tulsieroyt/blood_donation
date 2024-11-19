import 'package:blood_donation/src/common/widget/app_bar.dart';
import 'package:blood_donation/src/features/donation/presentation/controller/find_donor_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FindDonorScreen extends StatefulWidget {
  const FindDonorScreen({super.key});

  @override
  State<FindDonorScreen> createState() => _FindDonorScreenState();
}

class _FindDonorScreenState extends State<FindDonorScreen> {
  final findDonorController = Get.put(FindDonorController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BDAppBar(title: 'Find Donors'),
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.redAccent),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  children: [
                    const SizedBox(width: 16),
                    const Icon(
                      Icons.search,
                      color: Colors.redAccent,
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: findDonorController.locationText,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 0),
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedErrorBorder: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Obx(
                    () => findDonorController.donorList.isEmpty
                        ? const SizedBox(
                            height: 300,
                            width: double.infinity,
                            child: Center(
                              child: Text('No Donor Found!'),
                            ),
                          )
                        : ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: findDonorController.donorList.length,
                            separatorBuilder: (_, __) => Container(
                              height: 10,
                            ),
                            itemBuilder: (context, index) {
                              final donor =
                                  findDonorController.donorList[index];
                              return Container(
                                width: double.infinity,
                                height: 90,
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
                                  padding: const EdgeInsets.only(
                                      left: 5, top: 10, right: 10, bottom: 10),
                                  child: Row(
                                    children: <Widget>[
                                      Container(
                                        height: 80,
                                        width: 80,
                                        decoration: const BoxDecoration(
                                            color: Colors.white),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          child: donor.profilePicture.isEmpty
                                              ? Image.asset(
                                                  'assets/image/default-image.png')
                                              : Image.network(
                                                  donor.profilePicture),
                                        ),
                                      ),
                                      const SizedBox(width: 4),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
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
                                                    '${donor.firstName} ${donor.lastName}',
                                                    style: const TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.black87,
                                                      fontWeight:
                                                          FontWeight.w600,
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
                                                    donor.location,
                                                    style: const TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.black54,
                                                      fontWeight:
                                                          FontWeight.w600,
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
                                            donor.bloodGroup,
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
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
