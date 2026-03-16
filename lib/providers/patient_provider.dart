import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

import '../models/emergency_info_model.dart';
import '../models/medical_record_model.dart';
import '../models/prescription_model.dart';
import '../models/patient_model.dart';
import '../utils/mock_data.dart';

class PatientProvider extends ChangeNotifier {
  PatientModel? currentPatient;
  List<MedicalRecordModel> medicalRecords = [];
  List<PrescriptionModel> prescriptions = [];
  EmergencyInfoModel? emergencyInfo;

  bool isLoggedIn = false;
  bool isLoading = false;

  Future<void> login(String email, String password) async {
    isLoading = true;
    notifyListeners();

    try {
      await Future.delayed(const Duration(milliseconds: 500));

      // Simple mock login validation
      if (email.toLowerCase() == MockData.samplePatient.email.toLowerCase() &&
          password == 'password123') {
        currentPatient = MockData.samplePatient;
        isLoggedIn = true;
        loadMockData();
      } else {
        throw Exception('Invalid credentials');
      }
    } catch (_) {
      rethrow;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> register(PatientModel patient) async {
    isLoading = true;
    notifyListeners();

    try {
      currentPatient = patient;
      isLoggedIn = true;
      loadMockData();
    } catch (_) {
      rethrow;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void logout() {
    currentPatient = null;
    medicalRecords = [];
    prescriptions = [];
    emergencyInfo = null;
    isLoggedIn = false;
    notifyListeners();
  }

  void loadMockData() {
    medicalRecords = MockData.sampleRecords;
    prescriptions = MockData.samplePrescriptions;
    emergencyInfo = MockData.sampleEmergencyInfo;
    notifyListeners();
  }

  String generateId() => const Uuid().v4();
}
