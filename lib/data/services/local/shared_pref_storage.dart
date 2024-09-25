import 'dart:convert';
import 'package:booking_clinics_doctor/data/models/doctor_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefServices {
  static const String _doctorKey = 'doctor_data';

  // Save Patient object
  Future<void> saveDoctor(DoctorModel doctor) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String patientJson = jsonEncode(doctor.toJson());
    await prefs.setString(_doctorKey, patientJson);
  }

  // Get Patient object
  Future<DoctorModel?> getDoctor() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? doctorJson = prefs.getString(_doctorKey);

    if (doctorJson != null) {
      Map<String, dynamic> patientMap = jsonDecode(doctorJson);
      return DoctorModel.fromJson(patientMap);
    }
    return null;
  }
}