import 'package:booking_clinics_doctor/data/models/doctor_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/constant/const_string.dart';
import '../../../data/models/booking.dart';
import '../../../data/services/remote/firebase_auth.dart';

part 'appointment_state.dart';

class AppointmentCubit extends Cubit<AppointmentState> {
  int? index;
  List<Booking> pending = [];
  List<Booking> canceled = [];
  List<Booking> completed = [];
  final FirebaseAuthService _authService;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  AppointmentCubit(this._authService) : super(AppointmentLoading());

  // ! The Chart in HomeView
  Map<double, double> pendingCoord = {};
  Map<double, double> canceledCoord = {};
  Map<double, double> completedCoord = {};
  void _coordinate(List<Booking> bookings) {
    final Map<double, double> coordinates = {};
    for (Booking booking in bookings) {
      final date = _getDay(DateTime.parse(booking.date));
      coordinates.update(date, (val) => val++, ifAbsent: () => 0);
      pendingCoord.addEntries(coordinates.entries);
    }
    // print(pendingCoordinates.keys);
    // print(pendingCoordinates.values);
  }

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

  // ! Cancel in pending
  Future<void> cancelBooking({required int index}) async {
    try {
      emit(ActionClicked());
      pending[index].bookingStatus = "Canceled";
      // ! Update patient bookings
      final doctorRef = await _doctorRef;
      await doctorRef.update({
        'bookings': List<dynamic>.from(
          _compineBookings.map((booking) => booking.toJson()),
        )
      });
      // ! Update doctor bookings
      final patientRef = await _patientRef(pending[index].personId);
      await patientRef.update({
        'bookings': List<dynamic>.from(
          _compineBookings.map((booking) => booking.toJson()),
        )
      });
      debugPrint("Canceled Successfully!");
      canceled.insert(0, pending[index]);
      pending.removeAt(index);
      emit(AppointmentSuccess());
    } catch (e) {
      debugPrint("$e");
    }
  }

  // ! Reschedule in pending
  Future<void> reschadule({
    required String date,
    required String time,
  }) async {
    try {
      emit(ActionClicked());
      if (index == null) return;
      pending[index!].date = date;
      pending[index!].time = time;
      pending[index!].bookingStatus = "Pending";
      // ! Update patient bookings
      final ref = await _doctorRef;
      await ref.update({
        'bookings': List<dynamic>.from(
          _compineBookings.map((booking) => booking.toJson()),
        )
      });
      // ! Update doctor bookings
      final patientRef = await _patientRef(pending[index!].personId);
      await patientRef.update({
        'bookings': List<dynamic>.from(
          _compineBookings.map((booking) => booking.toJson()),
        )
      });
      emit(AppointmentSuccess());
    } catch (e) {
      debugPrint("$e");
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
      // ! Update doctor bookings
      // final doctorRef = await _doctorRef(patient.bookings[index!].id);
      // await doctorRef.update({
      //   'bookings': List<dynamic>.from(
      //     _compineBookings.map((booking) => booking.toJson()),
      //   )
      // });
      debugPrint('Pending bookings updated to Completed');
    }
  }

  // ! Filter bookings after get it from firebase and update it
  void _filterBookings(List<Booking> bookings) {
    for (int i = 0; i < bookings.length; i++) {
      if (bookings[i].bookingStatus == "Pending") {
        pending.add(bookings[i]);
      } else if (bookings[i].bookingStatus == "Completed") {
        completed.add(bookings[i]);
        // _coordinate(completed);
      } else if (bookings[i].bookingStatus == "Canceled") {
        canceled.add(bookings[i]);
        // _coordinate(canceled);
      } else {
        debugPrint(bookings[i].bookingStatus);
      }
    }
    _coordinate(pending);
    // _coordinate(canceled);
    // _coordinate(completed);
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
