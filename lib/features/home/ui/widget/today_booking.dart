import 'package:sizer/sizer.dart';
import 'package:iconsax/iconsax.dart';
import 'package:flutter/material.dart';
import '../../../../data/models/booking.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/common/custom_image.dart';
import '../../../appointment/manager/appointment_cubit.dart';
import 'package:booking_clinics_doctor/core/constant/extension.dart';
import 'package:booking_clinics_doctor/core/constant/const_color.dart';

class TodayBooking extends StatelessWidget {
  const TodayBooking({super.key});
  static const List<String> titles = ["Pending", "Completed", "Canceled"];

  @override
  Widget build(BuildContext context) {
    final read = context.read<AppointmentCubit>();
    final List<Booking> todayBooking = read.getTodayBookings();
    return BlocBuilder<AppointmentCubit, AppointmentState>(
      builder: (_, state) {
        if (state is AppointmentSuccess) {
          return Column(
            children: todayBooking.isEmpty
                ? [
                    SizedBox(height: 4.h),
                    Icon(Iconsax.book, size: 42.sp),
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
            children: List.generate(4, (index) => const Card()),
          );
        }
      },
    );
  }
}

class BookingCard extends StatelessWidget {
  final Booking booking;
  const BookingCard({required this.booking, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 1.5.h, top: 0.5.h),
      child: Padding(
        padding: EdgeInsets.all(1.h),
        child: Row(
          children: [
            CustomImage(image: booking.imageUrl),
            SizedBox(width: 1.5.h),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    booking.name,
                    maxLines: 1,
                    style: context.bold16,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Divider(height: 2.h),
                  Row(
                    children: [
                      Icon(Iconsax.clock, size: 20.sp),
                      SizedBox(width: 2.w),
                      Text(booking.time, style: context.regular14),
                      const Spacer(),
                      Container(
                        padding: EdgeInsetsDirectional.symmetric(
                          vertical: 0.5.h,
                          horizontal: 2.5.w,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.w),
                          gradient: detColor(booking.bookingStatus),
                        ),
                        child: Text(
                          booking.bookingStatus,
                          style: context.regular12?.copyWith(
                            height: 0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Gradient detColor(String status) {
    switch (status) {
      case "Pending":
        return blueToPurpleGradient;
      case "Completed":
        return greenToTealGradient;
      case "Canceled":
        return orangeToRedGradient;
      default:
        return const LinearGradient(colors: []);
    }
  }
}
