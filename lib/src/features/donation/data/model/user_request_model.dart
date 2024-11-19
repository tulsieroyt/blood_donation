import 'package:blood_donation/src/features/donation/data/model/request_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../common/model/user_model.dart';

class UserRequestModel {
  final UserModel user;
  final RequestModel request;

  UserRequestModel({
    required this.user,
    required this.request,
  });

  /// Convert the UserRequestModel to JSON for Firestore
  Map<String, dynamic> toJson() {
    return {
      'user': user.toJson(),
      'request': request.toJson(),
    };
  }

  /// Factory method to create a UserRequestModel from a Firestore QuerySnapshot
  static Future<UserRequestModel> fromSnapshot(
      QueryDocumentSnapshot<Map<String, dynamic>> snapshot) async {
    final data = snapshot.data();

    // Fetch the user document from the reference
    final userDoc = await snapshot.reference
        .firestore // Get Firestore instance from the snapshot reference
        .collection('users')
        .doc(data['userId'])
        .get();

    // Fetch the request document from the reference
    final requestDoc = await snapshot.reference
        .firestore // Get Firestore instance from the snapshot reference
        .collection(
            'requests') // Assuming the blood request collection is named 'requests'
        .doc(data['requestId'])
        .get();

    // Convert the snapshots to models
    final UserModel user = UserModel.fromSnapshot(userDoc);
    final RequestModel request = RequestModel.fromSnapshot(requestDoc);

    return UserRequestModel(
      user: user,
      request: request,
    );
  }

  /// Static method to create a UserRequestModel from Firestore DocumentSnapshot
  static Future<UserRequestModel> fromDocSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot) async {
    final data = snapshot.data()!;

    // Fetch the user document from the reference
    final userDoc = await snapshot.reference
        .firestore // Get Firestore instance from the snapshot reference
        .collection('users')
        .doc(data['userId'])
        .get();

    // Fetch the request document from the reference
    final requestDoc = await snapshot.reference
        .firestore // Get Firestore instance from the snapshot reference
        .collection(
            'requests') // Assuming the blood request collection is named 'requests'
        .doc(data['requestId'])
        .get();

    // Convert the snapshots to models
    final UserModel user = UserModel.fromSnapshot(userDoc);
    final RequestModel request = RequestModel.fromSnapshot(requestDoc);

    return UserRequestModel(
      user: user,
      request: request,
    );
  }
}
