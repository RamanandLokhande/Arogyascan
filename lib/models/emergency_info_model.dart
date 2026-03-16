import 'dart:convert';

class EmergencyInfoModel {
  final String patientId;
  final String bloodGroup;
  final List<String> allergies;
  final List<String> chronicDiseases;
  final String emergencyContactName;
  final String emergencyContactPhone;
  final String emergencyContactRelation;

  EmergencyInfoModel({
    required this.patientId,
    required this.bloodGroup,
    required this.allergies,
    required this.chronicDiseases,
    required this.emergencyContactName,
    required this.emergencyContactPhone,
    required this.emergencyContactRelation,
  });

  Map<String, dynamic> toMap() {
    return {
      'patientId': patientId,
      'bloodGroup': bloodGroup,
      'allergies': allergies,
      'chronicDiseases': chronicDiseases,
      'emergencyContactName': emergencyContactName,
      'emergencyContactPhone': emergencyContactPhone,
      'emergencyContactRelation': emergencyContactRelation,
    };
  }

  factory EmergencyInfoModel.fromMap(Map<String, dynamic> map) {
    return EmergencyInfoModel(
      patientId: map['patientId'] as String,
      bloodGroup: map['bloodGroup'] as String,
      allergies: List<String>.from(map['allergies'] as List<dynamic>),
      chronicDiseases:
          List<String>.from(map['chronicDiseases'] as List<dynamic>),
      emergencyContactName: map['emergencyContactName'] as String,
      emergencyContactPhone: map['emergencyContactPhone'] as String,
      emergencyContactRelation: map['emergencyContactRelation'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory EmergencyInfoModel.fromJson(String source) =>
      EmergencyInfoModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
