import 'dart:convert';

class PatientModel {
  final String id;
  final String fullName;
  final String dateOfBirth;
  final String gender;
  final String bloodGroup;
  final String phoneNumber;
  final String email;
  final String address;
  final String? profileImagePath;
  final DateTime registeredAt;

  PatientModel({
    required this.id,
    required this.fullName,
    required this.dateOfBirth,
    required this.gender,
    required this.bloodGroup,
    required this.phoneNumber,
    required this.email,
    required this.address,
    this.profileImagePath,
    required this.registeredAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'fullName': fullName,
      'dateOfBirth': dateOfBirth,
      'gender': gender,
      'bloodGroup': bloodGroup,
      'phoneNumber': phoneNumber,
      'email': email,
      'address': address,
      'profileImagePath': profileImagePath,
      'registeredAt': registeredAt.toIso8601String(),
    };
  }

  factory PatientModel.fromMap(Map<String, dynamic> map) {
    return PatientModel(
      id: map['id'] as String,
      fullName: map['fullName'] as String,
      dateOfBirth: map['dateOfBirth'] as String,
      gender: map['gender'] as String,
      bloodGroup: map['bloodGroup'] as String,
      phoneNumber: map['phoneNumber'] as String,
      email: map['email'] as String,
      address: map['address'] as String,
      profileImagePath: map['profileImagePath'] as String?,
      registeredAt: DateTime.parse(map['registeredAt'] as String),
    );
  }

  String toJson() => json.encode(toMap());

  factory PatientModel.fromJson(String source) =>
      PatientModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
