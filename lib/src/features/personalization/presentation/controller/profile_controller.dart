import 'dart:io';

import 'package:blood_donation/src/common/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../data/model/profile_option.dart';

class ProfileController extends GetxController {
  static ProfileController get instance => Get.find();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final _firebaseStorage = FirebaseStorage.instance;
  final _currentUser = FirebaseAuth.instance.currentUser;
  Rx<UserModel> userInfo = UserModel.empty().obs;

  File? image;
  final picker = ImagePicker();

  List<ProfileOption> profileOption = [
    ProfileOption(title: 'Blood Type', value: 'AB+'),
    ProfileOption(title: 'Donated', value: '6'),
    ProfileOption(title: 'Request', value: '2'),
  ];

  uploadProfilePicture() async {
    getImage();
    uploadImage();
  }

  Future<void> getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      image = File(pickedFile.path);
    } else {
      if (kDebugMode) {
        print("No image selected.");
      }
    }
    update();
  }

  uploadImage() async {
    try {
      String imageUrl = '';

      if (image != null) {
        var imageName = DateTime.now().microsecondsSinceEpoch.toString();
        var storageRef =
            _firebaseStorage.ref().child('profile_pictures/$imageName.jpg');

        UploadTask uploadTask = storageRef.putFile(image!);
        TaskSnapshot snapshot = await uploadTask.whenComplete(() {});

        if (snapshot.state == TaskState.success) {
          // Get the download URL of the image
          imageUrl = await snapshot.ref.getDownloadURL();

          // Update Firestore with the new profile picture URL
          await _firestore.collection('Users').doc(_currentUser!.uid).update({
            'profilePicture': imageUrl,
          });

          // Update the local userInfo object with the new profile picture URL
          userInfo.update((user) {
            if (user != null) {
              user.profilePicture = imageUrl;
            }
          });

          Get.snackbar("Success", "Profile picture updated successfully.");
        } else {
          Get.snackbar("Error", "Failed to upload image.");
          return;
        }
      } else {
        Get.snackbar("Error", "No image selected.");
      }
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  void onReady() {
    fetchUserInfo();
    super.onReady();
  }

  fetchUserInfo() async {
    try {
      final DocumentSnapshot<Map<String, dynamic>> basicInfo =
          await _firestore.collection('Users').doc(_currentUser!.uid).get();

      if (basicInfo.exists) {
        userInfo.value = UserModel.fromSnapshot(basicInfo);
      }

      if (kDebugMode) {
        print(userInfo.value.firstName);
        print(userInfo.value.profilePicture);
        print(userInfo.value.location);
      }
    } catch (e) {
      throw e.toString();
    }
  }
}
