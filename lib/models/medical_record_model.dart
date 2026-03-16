import 'dart:convert';

class MedicalRecordModel {
  final String id;
  final String patientId;
  final String doctorName;
  final String hospitalName;
  final String diagnosis;
  final String notes;
  final DateTime visitDate;
  final List<String> prescriptionIds;

  MedicalRecordModel({
    required this.id,
    required this.patientId,
    required this.doctorName,
    required this.hospitalName,
    required this.diagnosis,
    required this.notes,
    required this.visitDate,
    required this.prescriptionIds,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'patientId': patientId,
      'doctorName': doctorName,
      'hospitalName': hospitalName,
      'diagnosis': diagnosis,
      'notes': notes,
      'visitDate': visitDate.toIso8601String(),
      'prescriptionIds': prescriptionIds,
    };
  }

  factory MedicalRecordModel.fromMap(Map<String, dynamic> map) {
    return MedicalRecordModel(
      id: map['id'] as String,
      patientId: map['patientId'] as String,
      doctorName: map['doctorName'] as String,
      hospitalName: map['hospitalName'] as String,
      diagnosis: map['diagnosis'] as String,
      notes: map['notes'] as String,
      visitDate: DateTime.parse(map['visitDate'] as String),
      prescriptionIds:
          List<String>.from(map['prescriptionIds'] as List<dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory MedicalRecordModel.fromJson(String source) =>
      MedicalRecordModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
