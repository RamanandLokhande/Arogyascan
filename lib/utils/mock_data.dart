import '../models/emergency_info_model.dart';
import '../models/medical_record_model.dart';
import '../models/prescription_model.dart';
import '../models/patient_model.dart';

class MockData {
  MockData._();

  static PatientModel get samplePatient => PatientModel(
        id: 'PT-20240301-001',
        fullName: 'Rahul Sharma',
        dateOfBirth: '1992-06-15',
        gender: 'Male',
        bloodGroup: 'B+',
        phoneNumber: '+91 98765 43210',
        email: 'rahul.sharma@email.com',
        address:
            'Flat 4B, Green Park Apartments, Mumbai, Maharashtra - 400001',
        registeredAt: DateTime(2024, 3, 1),
      );

  static List<MedicalRecordModel> get sampleRecords => [
        MedicalRecordModel(
          id: 'MR-001',
          patientId: 'PT-20240301-001',
          doctorName: 'Dr. Priya Mehta',
          hospitalName: 'Apollo Hospital, Mumbai',
          diagnosis: 'Viral Fever & Mild Upper Respiratory Tract Infection',
          notes:
              'Patient advised rest for 5 days. Plenty of fluids recommended.',
          visitDate: DateTime(2024, 11, 12),
          prescriptionIds: ['RX-001', 'RX-002'],
        ),
        MedicalRecordModel(
          id: 'MR-002',
          patientId: 'PT-20240301-001',
          doctorName: 'Dr. Arun Kapoor',
          hospitalName: 'Lilavati Hospital, Mumbai',
          diagnosis: 'Seasonal Allergic Rhinitis',
          notes: 'Avoid dust and strong fragrances. Follow-up in 2 weeks.',
          visitDate: DateTime(2024, 8, 3),
          prescriptionIds: ['RX-003'],
        ),
        MedicalRecordModel(
          id: 'MR-003',
          patientId: 'PT-20240301-001',
          doctorName: 'Dr. Sneha Joshi',
          hospitalName: 'Kokilaben Hospital, Mumbai',
          diagnosis: 'Acute Gastroenteritis',
          notes: 'ORS recommended. Bland diet for 3 days.',
          visitDate: DateTime(2024, 4, 20),
          prescriptionIds: ['RX-004'],
        ),
      ];

  static List<PrescriptionModel> get samplePrescriptions => [
        PrescriptionModel(
          id: 'RX-001',
          patientId: 'PT-20240301-001',
          medicineName: 'Paracetamol 500mg',
          dosage: '500mg',
          frequency: 'Thrice daily after meals',
          duration: '5 days',
          prescribedBy: 'Dr. Priya Mehta',
          prescribedDate: DateTime(2024, 11, 12),
          isActive: true,
          instructions:
              'Take with warm water. Do not exceed 3 tablets per day.',
        ),
        PrescriptionModel(
          id: 'RX-002',
          patientId: 'PT-20240301-001',
          medicineName: 'Cetirizine 10mg',
          dosage: '10mg',
          frequency: 'Once daily at bedtime',
          duration: '5 days',
          prescribedBy: 'Dr. Priya Mehta',
          prescribedDate: DateTime(2024, 11, 12),
          isActive: true,
          instructions: 'May cause drowsiness. Avoid driving after intake.',
        ),
        PrescriptionModel(
          id: 'RX-003',
          patientId: 'PT-20240301-001',
          medicineName: 'Montelukast 10mg',
          dosage: '10mg',
          frequency: 'Once daily at night',
          duration: '30 days',
          prescribedBy: 'Dr. Arun Kapoor',
          prescribedDate: DateTime(2024, 8, 3),
          isActive: false,
          instructions:
              'Take consistently at the same time each evening.',
        ),
        PrescriptionModel(
          id: 'RX-004',
          patientId: 'PT-20240301-001',
          medicineName: 'ORS Sachet',
          dosage: '1 sachet in 200ml water',
          frequency: 'Every 4 hours',
          duration: '3 days',
          prescribedBy: 'Dr. Sneha Joshi',
          prescribedDate: DateTime(2024, 4, 20),
          isActive: false,
          instructions: 'Prepare fresh each time. Store in cool place.',
        ),
      ];

  static EmergencyInfoModel get sampleEmergencyInfo => EmergencyInfoModel(
        patientId: 'PT-20240301-001',
        bloodGroup: 'B+',
        allergies: ['Penicillin', 'Sulfa Drugs', 'Pollen'],
        chronicDiseases: ['Seasonal Rhinitis'],
        emergencyContactName: 'Sunita Sharma',
        emergencyContactPhone: '+91 98123 45678',
        emergencyContactRelation: 'Mother',
      );
}
