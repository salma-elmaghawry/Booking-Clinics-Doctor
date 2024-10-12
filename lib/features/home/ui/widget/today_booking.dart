import 'package:booking_clinics_doctor/core/common/skeleton.dart';
import 'package:booking_clinics_doctor/features/home/ui/widget/booking_card.dart';
import 'package:sizer/sizer.dart';
import 'package:iconsax/iconsax.dart';
import 'package:flutter/material.dart';
import '../../../../data/models/booking.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../appointment/manager/appointment_cubit.dart';
import 'package:booking_clinics_doctor/core/constant/extension.dart';
import 'package:booking_clinics_doctor/core/constant/const_color.dart';

class TodayBooking extends StatelessWidget {
  const TodayBooking({super.key});
  static const List<String> titles = ["Pending", "Completed", "Canceled"];

  @override
  Widget build(BuildContext context) {
    final read = context.read<AppointmentCubit>();
    return BlocBuilder<AppointmentCubit, AppointmentState>(
      builder: (_, state) {
        if (state is AppointmentSuccess) {
          final List<Booking> todayBooking = read.getTodayBookings();
          return Column(
            children: todayBooking.isEmpty
                ? [
                    SizedBox(height: 4.h),
                    Icon(Iconsax.calendar_1, size: 45.sp),
                    SizedBox(height: 2.h),
                    Text(
                      "No Bookings for Now",
                      style: context.regular14?.copyWith(
                        color: ConstColor.icon.color,
                      ),
                    ),
                  ]
                : List.generate(
                    todayBooking.length,
                    (index) => BookingCard(booking: todayBooking[index]),
                  ),
          );
        } else {
          return Column(
            children: List.generate(
              3,
              (index) => Skeleton(
                height: 10.h,
                width: double.infinity,
                margin: EdgeInsets.only(bottom: 1.5.h, top: 0.5.h),
              ),
            ),
          );
        }
      },
    );
  }
}
