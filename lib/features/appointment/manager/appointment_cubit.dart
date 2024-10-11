import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/constant/const_string.dart';
import '../../../data/models/booking.dart';
import '../../../data/models/doctor_model.dart';
import '../../../data/services/remote/firebase_auth.dart';
import '../../home/data/model/chart_model.dart';

part 'appointment_state.dart';

class AppointmentCubit extends Cubit<AppointmentState> {
  int? index;
  List<Booking> pending = [];
  List<Booking> canceled = [];
  List<Booking> completed = [];
  final FirebaseAuthService _authService;
  WeeklyBookingData weeklyData = WeeklyBookingData();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  AppointmentCubit(this._authService) : super(AppointmentLoading());

  // ! Get bookings when open the page first time
  Future<void> fetchBookings() async {
    try {
      final snapshot = await _doctorDoc;
      if (snapshot.exists) {
        DoctorModel doctor = DoctorModel.fromJson(
          snapshot.data() as Map<String, dynamic>,
        );
        await _updateStatus(doctor);
        _filterBookings(doctor.bookings);
        emit(AppointmentSuccess());
        debugPrint("${pending.length}|${completed.length}|${canceled.length}");
      }
    } catch (e) {
      emit(AppointmentFailure("$e"));
      debugPrint('Error fetching bookings: $e');
    }
  }

  // ! Update status for both user & doctor before filtering
  Future<void> _updateStatus(DoctorModel doctor) async {
    bool statusUpdated = false;
    DateTime currentDate = DateTime.now();

    for (int i = 0; i < doctor.bookings.length; i++) {
      if (doctor.bookings[i].bookingStatus == 'Pending') {
        DateTime bookingDate = DateTime.parse(doctor.bookings[i].date);
        if (bookingDate.isBefore(currentDate)) {
          doctor.bookings[i].bookingStatus = 'Completed';
          statusUpdated = true;
        }
      }
    }
    if (statusUpdated) {
      // ! Update doctor bookings
      final ref = await _doctorRef;
      List<Map<String, dynamic>> bookings =
          doctor.bookings.map((e) => e.toJson()).toList();
      await ref.update({'bookings': bookings});
      debugPrint('Pending bookings updated to Completed');
    }
  }

  // ! Get Keys of Chart from Bookings Date.
  static double _getDay(DateTime date) {
    switch (date.weekday) {
      case 7:
        return 0;
      case 1:
        return 1;
      case 2:
        return 2;
      case 3:
        return 3;
      case 4:
        return 4;
      case 5:
        return 5;
      case 6:
        return 6;
      default:
        return -1;
    }
  }

  // ! Add Chart Coordinates in HomeView.
  void _coordinates(Booking booking) {
    DateTime bookingDate = DateTime.parse(booking.date);
    double dayOfWeek = _getDay(bookingDate);
    weeklyData.updateBooking(dayOfWeek, booking.bookingStatus);
  }

  // ! Filter bookings after get it from firebase and update it
  void _filterBookings(List<Booking> bookings) {
    for (int i = 0; i < bookings.length; i++) {
      if (bookings[i].bookingStatus == "Pending") {
        pending.add(bookings[i]);
        _coordinates(bookings[i]);
      } else if (bookings[i].bookingStatus == "Completed") {
        completed.add(bookings[i]);
        _coordinates(bookings[i]);
      } else if (bookings[i].bookingStatus == "Canceled") {
        canceled.add(bookings[i]);
        _coordinates(bookings[i]);
      } else {
        debugPrint("Oops... Unable to Found ${bookings[i].bookingStatus}");
      }
    }
  }

  // ! Compine bookings before update it in firebase
  List<Booking> get _compineBookings =>
      [pending, canceled, completed].expand((i) => i).toList();

  // ! (0)
  Future<DocumentReference<Map<String, dynamic>>> get _doctorRef async =>
      _firestore
          .collection(ConstString.doctorsCollection)
          .doc(await _authService.getUid());

  // ! (1)
  Future<DocumentSnapshot<Map<String, dynamic>>> get _doctorDoc async =>
      await _firestore
          .collection(ConstString.doctorsCollection)
          .doc(await _authService.getUid())
          .get();

  // ! (2)
  Future<DocumentReference<Map<String, dynamic>>> _patientRef(
          String patientId) async =>
      _firestore.collection(ConstString.patientsCollection).doc(patientId);
}
