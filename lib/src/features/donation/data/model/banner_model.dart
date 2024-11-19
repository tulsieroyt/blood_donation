import 'package:cloud_firestore/cloud_firestore.dart';

class BannerModel {
  final String bannerUrl;

  BannerModel({required this.bannerUrl});

  // Convert BannerModel to JSON for Firestore
  Map<String, dynamic> toJson() {
    return {
      'bannerUrl': bannerUrl,
    };
  }

  // Factory method to create BannerModel from Firestore DocumentSnapshot
  factory BannerModel.fromSnapshot(DocumentSnapshot snapshot) {
    var data = snapshot.data() as Map<String, dynamic>;
    return BannerModel(
      bannerUrl: data['bannerUrl'] ?? '',
    );
  }
}
