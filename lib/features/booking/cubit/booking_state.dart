import 'package:flutter/material.dart';

@immutable
abstract class BookAppointmentState {}

class BookAppointmentInitial extends BookAppointmentState {}

class DateSelectedState extends BookAppointmentState {
  final DateTime selectedDate;

  DateSelectedState(this.selectedDate);
}

class HourSelectedState extends BookAppointmentState {
  final DateTime selectedDate;
  final String selectedHour;

  HourSelectedState(this.selectedDate, this.selectedHour);
}