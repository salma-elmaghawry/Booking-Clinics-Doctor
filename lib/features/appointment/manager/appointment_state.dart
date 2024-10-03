part of 'appointment_cubit.dart';

sealed class AppointmentState {}

final class AppointmentInitial extends AppointmentState {}

final class AppointmentLoading extends AppointmentState {}

final class AppointmentSuccess extends AppointmentState {}

final class AppointmentFailure extends AppointmentState {
  final String error;
  AppointmentFailure(this.error);
}

// ! Action Buttons
final class ActionClicked extends AppointmentState {}

final class CancelBooking extends AppointmentState {
  final Booking booking;
  CancelBooking(this.booking);
}

// ! Add Review
final class PostFeedBackSuccess extends AppointmentState {}

final class PostFeedBackLoading extends AppointmentState {}