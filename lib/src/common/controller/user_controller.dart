import 'package:get/get.dart';

import '../model/user_model.dart';
import '../repository/user_repository.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();

  Rx<UserModel> user = UserModel.empty().obs;

  final userRepository = Get.put(UserRepository());

  Future<void> fetchUserData() async {
    try {
      final user = await userRepository.fetchUserDetails();
      this.user(user);
    } catch (e) {
      throw 'Something went wrong!. Please try again.';
    }
  }
}
