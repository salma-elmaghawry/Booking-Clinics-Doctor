import 'package:booking_clinics_doctor/data/models/doctor_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Method to get user location
  Future<Map<String, dynamic>> getUserLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    // Request permission to access location
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied.');
    }

    // Get the current position (latitude & longitude)
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    // Return the location as a map
    return {
      'latitude': position.latitude,
      'longitude': position.longitude,
    };
  }

  Future<User?> signUpWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = userCredential.user;

      if (user != null) {
        await user.sendEmailVerification();
      }
      return user;
    } catch (e) {
      return null;
    }
  }

  Future<void> addDoctorFireStore(DoctorModel doctor) async {
    try {
      await _firestore
          .collection('doctors')
          .doc(doctor.id)
          .set(doctor.toJson());
    } catch (e) {
      rethrow;
    }
  }

  // Login with Email and Password
  Future<User?> loginWithEmailAndPassword(String email, String password, BuildContext context) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = userCredential.user;

      if (user != null) {
        if (user.emailVerified) {


          await _saveUid(user.uid);
          await _setLoginStatus(true);
          return user;
        }

        else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Please verify your email first'),
              backgroundColor: Colors.red,
            ),
          );
          return null;
        }
      }
    } catch (e) {
      return null;
    }
    return null;
  }

  // Send Password Reset Email
  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      return;
    }
  }

  // Sign Out
  Future<void> signOut() async {
    await _auth.signOut();
    await _setLoginStatus(false);
  }

  // Save UID in SharedPreferences
  Future<void> _saveUid(String uid) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('uid', uid);
  }

  // Get UID from SharedPreferences
  Future<String?> getUid() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('uid');
  }

  // Save Login Status in SharedPreferences
  Future<void> _setLoginStatus(bool isLoggedIn) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', isLoggedIn);
  }

  // Get Login Status from SharedPreferences
  Future<bool> isLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn') ?? false;
  }

  /// Fetches a doctor by ID from the doctors collection.
  Future<DoctorModel?> getDoctorById(BuildContext context, String doctorId) async {
    try {
      final docSnapshot = await _firestore.collection("doctors").doc(doctorId).get();

      if (docSnapshot.exists) {
        return DoctorModel.fromJson(docSnapshot.data() as Map<String, dynamic>);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("This Email isn't registered as a doctor!"),
            backgroundColor: Colors.red,
          ),
        );
        return null;
      }
    } catch (e) {
      print('Error fetching doctor by ID: $e');
      // Optionally show snackbar on error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error fetching doctor: $e'),
          backgroundColor: Colors.red,
        ),
      );
      rethrow;
    }
  }
}
