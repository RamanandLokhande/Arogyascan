import 'dart:convert';

class PrescriptionModel {
  final String id;
  final String patientId;
  final String medicineName;
  final String dosage;
  final String frequency;
  final String duration;
  final String prescribedBy;
  final DateTime prescribedDate;
  final bool isActive;
  final String instructions;

  PrescriptionModel({
    required this.id,
    required this.patientId,
    required this.medicineName,
    required this.dosage,
    required this.frequency,
    required this.duration,
    required this.prescribedBy,
    required this.prescribedDate,
    required this.isActive,
    required this.instructions,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'patientId': patientId,
      'medicineName': medicineName,
      'dosage': dosage,
      'frequency': frequency,
      'duration': duration,
      'prescribedBy': prescribedBy,
      'prescribedDate': prescribedDate.toIso8601String(),
      'isActive': isActive,
      'instructions': instructions,
    };
  }

  factory PrescriptionModel.fromMap(Map<String, dynamic> map) {
    return PrescriptionModel(
      id: map['id'] as String,
      patientId: map['patientId'] as String,
      medicineName: map['medicineName'] as String,
      dosage: map['dosage'] as String,
      frequency: map['frequency'] as String,
      duration: map['duration'] as String,
      prescribedBy: map['prescribedBy'] as String,
      prescribedDate: DateTime.parse(map['prescribedDate'] as String),
      isActive: map['isActive'] as bool,
      instructions: map['instructions'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory PrescriptionModel.fromJson(String source) =>
      PrescriptionModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
