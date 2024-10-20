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
  List<Booking> compined = [];
  final FirebaseAuthService _authService;
  WeeklyBookingData weeklyData = WeeklyBookingData();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  AppointmentCubit(this._authService) : super(AppointmentInitial());

  Future<void> agreeBooking({required int index}) async {
    try {
      emit(ActionClicked());
      pending[index].isAccepted = 1;
      // pending[index].bookingStatus = "Canceled";
      // ! Update patient bookings
      final patientRef = await _patientRef(pending[index].personId);
      await patientRef.update({
        'bookings': List<dynamic>.from(
          _compineBookings.map((booking) => booking.toJson()),
        ),
      });
      // ! Update doctor bookings
      await _updateDoctorBookings(
        index: index,
        bookings: pending,
        updatedBooking: pending[index],
      );
      debugPrint("Rejected Succesfully!");
      emit(AppointmentSuccess());
    } catch (e) {
      debugPrint("$e");
      debugPrint("Oops... Error in reject method!");
    }
  }

  Future<void> rejectBooking({required int index}) async {
    try {
      emit(ActionClicked());
      pending[index].isAccepted = -1;
      pending[index].bookingStatus = "Canceled";
      // ! Update patient bookings
      final patientRef = await _patientRef(pending[index].personId);
      await patientRef.update({
        'bookings': List<dynamic>.from(
          _compineBookings.map((booking) => booking.toJson()),
        ),
      });
      // ! Update doctor bookings
      await _updateDoctorBookings(
        index: index,
        bookings: pending,
        updatedBooking: pending[index],
      );
      canceled.insert(0, pending[index]);
      pending.removeAt(index);
      debugPrint("Rejected Succesfully!");
      emit(AppointmentSuccess());
    } catch (e) {
      debugPrint("$e");
      debugPrint("Oops... Error in reject method!");
    }
  }

  // ! Retrive, Search then Update doctor bookings in firestore
  Future<void> _updateDoctorBookings({
    required int index,
    required Booking updatedBooking,
    required List<Booking> bookings,
  }) async {
    try {
      final snapshot = await _doctorDoc;
      if (snapshot.exists) {
        DoctorModel doctor = DoctorModel.fromJson(
          snapshot.data() as Map<String, dynamic>,
        );
        final int bookingIndex = doctor.bookings.indexWhere(
          (booking) => booking.bookingId == bookings[index].bookingId,
        );
        if (bookingIndex != -1) {
          doctor.bookings[bookingIndex].isAccepted = updatedBooking.isAccepted;
          doctor.bookings[bookingIndex].bookingStatus =
              updatedBooking.bookingStatus;
          // doctor.bookings[bookingIndex].date = updatedBooking.date;
          // doctor.bookings[bookingIndex].time = updatedBooking.time;
          final ref = await _doctorRef;
          await ref.update({
            'bookings': List.from(
              doctor.bookings.map((booking) => booking.toJson()),
            ),
          });
        }
      }
    } catch (e) {
      debugPrint("Error Update Doctor Bookings: $e");
    }
  }

  // ! Get bookings when open the page first time
  Future<void> fetchBookings() async {
    emit(AppointmentLoading());
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

    // * List to keep track of bookings to keep after cleaning up old bookings
    List<Booking> bookingsToKeep = [];

    for (Booking booking in doctor.bookings) {
      DateTime bookingDate = DateTime.parse(booking.date);

      // * Update Pending bookings to Completed if their date is in the past
      if (booking.bookingStatus == 'Pending' &&
          bookingDate.isBefore(
              DateTime(currentDate.year, currentDate.month, currentDate.day))) {
        booking.bookingStatus = 'Completed';
        statusUpdated = true;
      }

      // * Remove bookings that are either Completed or Canceled and older than a week
      if ((booking.bookingStatus == 'Completed' ||
              booking.bookingStatus == 'Canceled') &&
          bookingDate.isBefore(currentDate.subtract(const Duration(days: 7)))) {
        continue; // Skip adding this booking to the bookingsToKeep list, effectively deleting it
      }

      // * Keep all other bookings
      bookingsToKeep.add(booking);
    }

    // * Update Firestore only if there were changes in the status or bookings list
    if (statusUpdated || bookingsToKeep.length != doctor.bookings.length) {
      final ref = await _doctorRef;
      List<Map<String, dynamic>> updatedBookings =
          bookingsToKeep.map((booking) => booking.toJson()).toList();
      await ref.update({'bookings': updatedBookings});
      debugPrint(
          'Bookings updated: Pending to Completed, & old bookings deleted.');
    }
  }

  // ! Get Keys of Chart from Bookings Date.
  static double _getDay(DateTime date) {
    switch (date.weekday) {
      case DateTime.sunday:
        return 0; // Sunday
      case DateTime.monday:
        return 1;
      case DateTime.tuesday:
        return 2;
      case DateTime.wednesday:
        return 3;
      case DateTime.thursday:
        return 4;
      case DateTime.friday:
        return 5;
      case DateTime.saturday:
        return 6; // Saturday
      default:
        return -1;
    }
  }

  // ! Add Chart Coordinates in HomeView, [Weekly Bookings].
  // void _coordinates(Booking booking) {
  //   DateTime bookingDate = DateTime.parse(booking.date);
  //   double dayOfWeek = _getDay(bookingDate);
  //   weeklyData.updateBooking(dayOfWeek, booking.bookingStatus);
  // }
  // void _coordinates(Booking booking) {
  //   DateTime now = DateTime.now();
  //   DateTime bookingDate = DateTime.parse(booking.date);

  //   // * Calculate the start and end of the current week
  //   DateTime startOfWeek =
  //       now.subtract(Duration(days: now.weekday - 1)); // Monday
  //   DateTime endOfWeek = startOfWeek.add(const Duration(days: 6)); // Sunday

  //   // * Check if the booking date is within this week
  //   if (bookingDate.isAfter(startOfWeek.subtract(const Duration(days: 1))) &&
  //       bookingDate.isBefore(endOfWeek.add(const Duration(days: 1)))) {
  //     double dayOfWeek = _getDay(bookingDate);
  //     weeklyData.updateBooking(dayOfWeek, booking.bookingStatus);
  //   }
  // }

  void _coordinates(Booking booking) {
    DateTime now = DateTime.now();
    DateTime bookingDate = DateTime.parse(booking.date);

    // * Calculate the start and end of the current week with Sunday as the start
    DateTime startOfWeek =
        now.subtract(Duration(days: now.weekday % 7)); // Sunday
    DateTime endOfWeek = startOfWeek.add(const Duration(days: 6)); // Saturday

    // * Check if the booking date is within this week
    if (bookingDate.isAfter(startOfWeek.subtract(const Duration(days: 1))) &&
        bookingDate.isBefore(endOfWeek.add(const Duration(days: 1)))) {
      double dayOfWeek = _getDay(bookingDate);
      weeklyData.updateBooking(dayOfWeek, booking.bookingStatus);
    }
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
    compined = _compineBookings;
  }

  // ! Get bookings for today
  List<Booking> getTodayBookings() {
    final DateTime today = DateTime.now();
    return compined.where((booking) {
      DateTime bookingDate = DateTime.parse(booking.date);
      return bookingDate.year == today.year &&
          bookingDate.month == today.month &&
          bookingDate.day == today.day;
    }).toList();
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
    String patientId,
  ) async =>
      _firestore.collection(ConstString.patientsCollection).doc(patientId);
}
