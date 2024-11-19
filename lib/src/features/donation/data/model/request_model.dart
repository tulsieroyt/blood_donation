import 'package:cloud_firestore/cloud_firestore.dart';

class RequestModel {
  String? requestId; // Nullable requestId since it's unknown at the time of creation
  String patientName;
  String bloodType;
  String location;
  String mobile;
  String? note; // Nullable note field
  Timestamp createdAt;

  RequestModel({
    this.requestId, // Set requestId after creation
    required this.patientName,
    required this.bloodType,
    required this.location,
    required this.mobile,
    this.note, // Nullable note
    required this.createdAt,
  });

  // Converts RequestModel to JSON for Firestore
  Map<String, dynamic> toJson() {
    return {
      'patientName': patientName,
      'bloodType': bloodType,
      'location': location,
      'mobile': mobile,
      'note': note ?? '', // Use empty string if note is null
      'createdAt': createdAt,
    };
  }

  // Factory function to create a RequestModel from a Firestore DocumentSnapshot
  factory RequestModel.fromSnapshot(DocumentSnapshot snapshot) {
    var data = snapshot.data() as Map<String, dynamic>;

    return RequestModel(
      requestId: snapshot.id, // The ID of the document from Firestore
      patientName: data['patientName'] ?? '',
      bloodType: data['bloodType'] ?? '',
      location: data['location'] ?? '',
      mobile: data['mobile'] ?? '',
      note: data['note'] ?? '',
      createdAt: data['createdAt'] ?? Timestamp.now(),
    );
  }
}
