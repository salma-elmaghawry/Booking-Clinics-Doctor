import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/patient.dart';

class SharedPrefServices {
  static const String _patientKey = 'patient_data';

  // Save Patient object
  Future<void> savePatient(Patient patient) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String patientJson = jsonEncode(patient.toJson());
    await prefs.setString(_patientKey, patientJson);
  }

  // Get Patient object
  Future<Patient?> getPatient() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? patientJson = prefs.getString(_patientKey);

    if (patientJson != null) {
      Map<String, dynamic> patientMap = jsonDecode(patientJson);
      return Patient.fromJson(patientMap);
    }
    return null;
  }

  // Clear patient data
  Future<void> clearPatientData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_patientKey);
  }
}