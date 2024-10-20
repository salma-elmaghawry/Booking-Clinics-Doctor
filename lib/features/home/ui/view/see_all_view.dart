import 'package:booking_clinics_doctor/core/common/skeleton.dart';
import 'package:booking_clinics_doctor/features/appointment/manager/appointment_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/helper/onrefresh.dart';
import '../../../../data/models/booking.dart';
import '../widget/booking_card.dart';
import 'package:flutter/material.dart';

class SeeAllView extends StatelessWidget {
  const SeeAllView({super.key});

  @override
  Widget build(BuildContext context) {
    final read = context.read<AppointmentCubit>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Today Bookings"),
      ),
      body: BlocBuilder<AppointmentCubit, AppointmentState>(
        builder: (_, state) {
          if (state is AppointmentSuccess) {
            final List<Booking> todayBooking = read.getTodayBookings();
            return RefreshIndicator(
              onRefresh: () async => await onRefreshAppointment(context),
              child: ListView.builder(
                itemCount: todayBooking.length,
                padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                itemBuilder: (_, index) {
                  return BookingCard(booking: todayBooking[index]);
                },
              ),
            );
          }
          return ListView.separated(
            itemCount: 5,
            padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
            itemBuilder: (_, index) {
              return Skeleton(
                height: 10.h,
                width: double.infinity,
                margin: EdgeInsets.only(bottom: 1.5.h, top: 0.5.h),
              );
            },
            separatorBuilder: (_, index) => SizedBox(height: 1.5.h),
          );
        },
      ),
    );
  }
}
