import 'package:blood_donation/src/features/donation/data/model/banner_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class BannerController extends GetxController {
  static BannerController get instance => Get.find();
  final _firestore = FirebaseFirestore.instance;
  RxList<BannerModel> bannerList = <BannerModel>[].obs;

  @override
  void onReady() {
    getAllBanner();
    super.onReady();
  }

  getAllBanner() async {
    try {
      final QuerySnapshot<Map<String, dynamic>> bannerRef =
          await _firestore.collection('Banner').get();

      bannerList.value =
          bannerRef.docs.map((doc) => BannerModel.fromSnapshot(doc)).toList();
    } catch (e) {
      throw e.toString();
    }
  }
}
