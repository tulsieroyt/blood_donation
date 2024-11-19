import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/model/user_model.dart';
import '../../data/model/request_model.dart';
import '../../data/model/user_request_model.dart';

class RequestBloodController extends GetxController {
  static RequestBloodController get instance => Get.find();

  final patientName = TextEditingController();
  final bloodType = TextEditingController();
  final location = TextEditingController();
  final mobile = TextEditingController();
  final problem = TextEditingController();
  GlobalKey<FormState> requestFromKey = GlobalKey<FormState>();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  RxList<RequestModel> requests = <RequestModel>[].obs;
  RxList<UserRequestModel> userRequests = <UserRequestModel>[].obs;
  String userId = FirebaseAuth.instance.currentUser!.uid;

  @override
  void onInit() {
    fetchAllRequests();
    print(userRequests.length.toString());
    super.onInit();
  }

  createRequest() async {
    try {
      print('call');
      if (!requestFromKey.currentState!.validate()) {
        print('call 1');
        return;
      }
      print('call');
      final DocumentReference requestRef =
          _firestore.collection('Request').doc();

      print('call');
      // Prepare the request model data
      RequestModel request = RequestModel(
        patientName: patientName.text.trim(),
        bloodType: bloodType.text.trim(),
        location: location.text.trim(),
        mobile: mobile.text.trim(),
        note: problem.text.trim(),
        createdAt:
            Timestamp.now(), // Firebase timestamp for request creation time
      );
      print('call');
      // Create the request in the "Request" collection
      requestRef.set(request.toJson());
      print('call');
      // Create the UserRequest relation to trace which user requested for blood
      await createUserPostEntity(userId, requestRef.id);
      print('call');
      // Clear the form after successful submission
      patientName.clear();
      bloodType.clear();
      location.clear();
      mobile.clear();
      problem.clear();

      Get.back();
    } catch (e) {
      Get.snackbar("Error", e.toString());
      throw e.toString();
    }
  }

  Future<void> fetchAllRequests() async {
    // Fetch all documents from the `UserRequest` collection
    QuerySnapshot userRequestsSnapshot =
        await _firestore.collection('UserRequest').get();

    // Clear the existing requests and userRequests list
    requests.clear();
    userRequests.clear();

    // Loop through each document in the `UserRequest` collection
    for (var userRequestDoc in userRequestsSnapshot.docs) {
      // Extract userId and requestId from the UserRequest document
      String userId = userRequestDoc['userId'];
      String requestId = userRequestDoc['requestId'];

      // Fetch the request information using requestId
      DocumentSnapshot requestDoc =
          await _firestore.collection('Request').doc(requestId).get();

      if (requestDoc.exists) {
        // Convert requestDoc to RequestModel
        RequestModel request = RequestModel.fromSnapshot(requestDoc);

        // Fetch the user information using userId
        DocumentSnapshot userDoc =
            await _firestore.collection('Users').doc(userId).get();

        if (userDoc.exists) {
          // Convert userDoc to UserModel
          UserModel user = UserModel.fromSnapshot(
              userDoc as DocumentSnapshot<Map<String, dynamic>>);

          // Create UserRequestModel and add it to the list
          userRequests.add(UserRequestModel(user: user, request: request));
        }
      }
    }

    if (kDebugMode) {
      print(userRequests);
    }
  }

  Future<void> createUserPostEntity(String userId, String postId) async {
    await _firestore.collection('UserRequest').add({
      'userId': userId,
      'requestId': postId,
    });
  }
}
