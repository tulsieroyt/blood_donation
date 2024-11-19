import 'package:blood_donation/src/common/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class FindDonorController extends GetxController {
  static FindDonorController get instance => Get.find();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  TextEditingController locationText = TextEditingController();

  RxList<UserModel> donorList = <UserModel>[].obs;

  @override
  void onInit() {
    // Add listener to search for donors dynamically as user types
    locationText.addListener(() {
      getDonorBasedOnLocation(locationText.text);
    });
    super.onInit();
  }

  @override
  void onReady() {
    getAllDonorList();  // Load all donors when the screen is ready
    super.onReady();
  }

  // Fetch all donors initially
  getAllDonorList() async {
    try {
      final QuerySnapshot<Map<String, dynamic>> donorRef =
      await _firestore.collection('Users').get();

      donorList.clear();
      for (var doc in donorRef.docs) {
        donorList.add(UserModel.fromSnapshot(doc));
      }

      if (kDebugMode) {
        print(donorList);
      }
    } catch (e) {
      throw e.toString();
    }
  }

  // Fetch donors based on location dynamically
  getDonorBasedOnLocation(String location) async {
    try {
      if (location.isEmpty) {
        getAllDonorList();  // If search field is empty, show all donors
        return;
      }

      final QuerySnapshot<Map<String, dynamic>> specificLocationDonorRef =
      await _firestore
          .collection('Users')
          .where('Location', isGreaterThanOrEqualTo: location)
          .where('Location', isLessThanOrEqualTo: location + '\uf8ff')
          .get();

      donorList.clear();
      for (var doc in specificLocationDonorRef.docs) {
        donorList.add(UserModel.fromSnapshot(doc));
      }

      if (kDebugMode) {
        print(donorList);
      }
    } catch (e) {
      throw e.toString();
    }
  }
}
