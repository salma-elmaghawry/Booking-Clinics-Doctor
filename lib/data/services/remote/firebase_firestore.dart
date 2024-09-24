import 'package:cloud_firestore/cloud_firestore.dart';
import '../../models/booking.dart';
import '../../models/doctor_model.dart';
import '../../models/favorite.dart';
import '../../models/patient.dart';

class FirebaseFirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _patientsCollection = 'patients';
  final String _doctorsCollection = 'doctors';

  /// Adds a new patient to the patients collection.
  Future<void> addPatient(Patient patient) async {
    try {
      await _firestore
          .collection(_patientsCollection)
          .doc(patient.uid)
          .set(patient.toJson());
    } catch (e) {
      print('Error adding patient: $e');
      rethrow;
    }
  }

  /// Updates specific fields in a patient document.
  Future<void> updatePatientFields(String uid, Map<String, dynamic> updatedFields) async {
    try {
      await _firestore
          .collection(_patientsCollection)
          .doc(uid)
          .update(updatedFields);
    } catch (e) {
      print('Error updating user fields: $e');
      rethrow;
    }
  }

  // Updates a patient document.
  Future<void> updateUser(updatedPatient) async {
    try {
      await _firestore
          .collection(_patientsCollection)
          .doc(updatedPatient.uid)
          .set(updatedPatient.toJson());
    } catch (e) {
      print('Error updating user: $e');
      rethrow;
    }
  }

  /// Fetches all doctors from the doctors collection.
  Future<List<DoctorModel>> getDoctors() async {
    try {
      final querySnapshot = await _firestore.collection(_doctorsCollection).get();
      return querySnapshot.docs
          .map((doc) => DoctorModel.fromJson(doc.data()))
          .toList();
    } catch (e) {
      print('Error fetching doctors: $e');
      rethrow;
    }
  }

  /// Fetches a doctor by ID from the doctors collection.
  Future<DoctorModel?> getDoctorById(String doctorId) async {
    try {
      final docSnapshot = await _firestore.collection(_doctorsCollection).doc(doctorId).get();
      if (docSnapshot.exists) {
        return DoctorModel.fromJson(docSnapshot.data() as Map<String, dynamic>);
      }
      return null;
    } catch (e) {
      print('Error fetching doctor by ID: $e');
      rethrow;
    }
  }

  /// Fetches a Patient by ID.
  Future<Patient?> getPatientById(String patientId) async {
    try {
      final docSnapshot = await _firestore.collection(_patientsCollection).doc(patientId).get();
      if (docSnapshot.exists) {
        return Patient.fromJson(docSnapshot.data() as Map<String, dynamic>);
      }
      return null;
    } catch (e) {
      print('Error fetching doctor by ID: $e');
      rethrow;
    }
  }

  /// Adds a booking to the patient's list of bookings in Firestore.
  Future<void> addBookingToPatient(String patientUid, Booking booking) async {
    try {
      await _firestore
          .collection(_patientsCollection)
          .doc(patientUid)
          .update({
        'bookings': FieldValue.arrayUnion([booking.toJson()]),
      });
    } catch (e) {
      print('Error adding booking: $e');
      rethrow;
    }
  }

  Future<void> addFavoriteToPatient(String patientId, Favorite favorite) async {
    try {
      final patientRef = _firestore.collection(_patientsCollection).doc(patientId);

      // Add the favorite to the favorites array
      await patientRef.update({
        'favorites': FieldValue.arrayUnion([favorite.toJson()]),
      });
    } catch (e) {
      throw Exception('Failed to add favorite: $e');
    }
  }

  Future<List<Favorite>> getFavoritesForPatient(String patientId) async {
    try {
      final patientRef = _firestore.collection(_patientsCollection).doc(patientId);
      final doc = await patientRef.get();
      if (doc.exists) {
        final data = doc.data();
        if (data != null && data['favorites'] != null) {
          final favoritesJson = List<Map<String, dynamic>>.from(data['favorites']);
          print("fetched favorites: $favoritesJson");
          return favoritesJson.map((json) => Favorite.fromJson(json)).toList();
        } else {
          print("No favorites found for patient: $patientId");
          return [];
        }
      }
      return [];
    } catch (e) {
      throw Exception('Failed to get favorites: $e');
    }
  }

  Future<void> removeFavoriteFromPatient(String patientId, Favorite favorite) async {
    try {
      final patientRef = _firestore.collection(_patientsCollection).doc(patientId);

      // Remove the favorite from the favorites array
      await patientRef.update({
        'favorites': FieldValue.arrayRemove([favorite.toJson()]),
      });
    } catch (e) {
      throw Exception('Failed to remove favorite: $e');
    }
  }

  Future<List<Booking>> getBookingsForPatient(String patientId) async {

    try {
      final patientRef = _firestore.collection(_patientsCollection).doc(patientId);
      final docSnapshot = await patientRef.get();

      if (docSnapshot.exists) {
        final data = docSnapshot.data();
        if (data != null && data['bookings'] != null) {
          // Convert the list of JSON bookings into a List<Booking> object
          final bookingsJson = List<Map<String, dynamic>>.from(data['bookings']);
          return bookingsJson.map((json) => Booking.fromJson(json)).toList();
        }
      }
      // If no bookings exist, return an empty list
      return [];
    } catch (e) {
      print('Error fetching bookings: $e');
      throw Exception('Failed to get bookings for patient: $e');
    }
  }

}
