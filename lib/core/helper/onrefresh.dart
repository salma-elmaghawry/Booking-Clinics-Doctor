import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../features/appointment/manager/appointment_cubit.dart';

Future<void> onRefreshAppointment(BuildContext context) async {
  final cubit = context.read<AppointmentCubit>();
  cubit.canceled.clear();
  cubit.pending.clear();
  cubit.compined.clear();
  cubit.completed.clear();
  await cubit.fetchBookings();
}
