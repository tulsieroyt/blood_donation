import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String id;
  String firstName;
  String lastName;
  final String email;
  String phoneNumber;
  String bloodGroup;
  String profilePicture;
  String location;

  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.bloodGroup,
    required this.location,
    required this.profilePicture,
  });

  /// get full name
  String get fullName => '$firstName $lastName';

  // to split the full name
  static List<String> nameParts(fullName) => fullName.split(" ");

  //generate username from the full name
  static String generateUserName(fullName) {
    List<String> nameParts = fullName.split(" ");
    String firstName = nameParts[0].toLowerCase();
    String lastName = nameParts.length> 1 ? nameParts[1].toLowerCase() : "" ;
    String camelCaseUserName = "$firstName$lastName";
    String userNameWithFixedPrefix = 'alumni_$camelCaseUserName';
    return userNameWithFixedPrefix;
  }

  ///Static function to create a empty user model
  static UserModel empty() => UserModel(
    id: '',
    firstName: '',
    lastName: '',
    email: '',
    phoneNumber: '',
    bloodGroup: ' ',
    location: ' ',
    profilePicture: '',
  );
  ///Convert model to JSON structure for storing data to Firebase
  Map<String, dynamic> toJson() {
    return {
      'FirstName': firstName,
      'LastName': lastName,
      'BloodGroup': bloodGroup,
      'Email': email,
      'PhoneNumber': phoneNumber,
      'Location': location,
      'ProfilePicture': profilePicture,
    };
  }

  ///Factory method to create a UserModel from the Firebase document snapshot
  factory UserModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return UserModel(
          id: document.id,
          firstName: data['FirstName'] ?? '',
          lastName: data['LastName'] ?? '',
          email: data['Email'] ?? '',
          phoneNumber: data['PhoneNumber'] ?? '',
          bloodGroup: data['BloodGroup'],
          location: data['Location'],
          profilePicture: data['ProfilePicture'] ?? '',
      );
    } else {
      return UserModel.empty();
    }
  }

}
