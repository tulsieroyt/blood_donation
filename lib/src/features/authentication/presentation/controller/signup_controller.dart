import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/model/user_model.dart';
import '../../../../common/repository/authentication_repository.dart';
import '../../../../common/repository/user_repository.dart';
import '../screen/signin_screen.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.find();
  final email = TextEditingController();
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final password = TextEditingController();
  final phoneNumber = TextEditingController();
  final bloodGroup = TextEditingController();
  final location  = TextEditingController();
  GlobalKey<FormState> signUpFormKey = GlobalKey<FormState>();

  Future<void> createAccount() async {
    try {
      final userCredit =
          await AuthenticationRepository.instance.registerWithEmailAndPassword(
        email.text.trim(),
        password.text.trim(),
      );

      print('Hello');
      //Save authentication data to firebase storage
      final newUser = UserModel(
        id: userCredit.user!.uid,
        firstName: firstName.text.trim(),
        lastName: lastName.text.trim(),
        email: email.text.trim(),
        bloodGroup: bloodGroup.text.trim(),
        phoneNumber: phoneNumber.text.trim(),
        profilePicture: '',
        location: location.text.trim(),
      );

      final userRepository = Get.put(UserRepository());
      await userRepository.saveUserRecord(newUser);

      if (kDebugMode) {
        print('Sign up successful');
      }

      Get.to(const SignInScreen());
    } catch (e) {
      throw 'Something went wrong! Please try again.';
    }
  }
}
