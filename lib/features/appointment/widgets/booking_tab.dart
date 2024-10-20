import 'package:booking_clinics_doctor/core/constant/const_color.dart';
import 'package:booking_clinics_doctor/core/constant/extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sizer/sizer.dart';
import '../../../core/common/loading_indicator.dart';
import '../../../data/models/booking.dart';
import '../manager/appointment_cubit.dart';
import 'action_buttons.dart';
import 'booking_card.dart';

class BookingTab extends StatelessWidget {
  final String status;
  final List<Booking> bookings;
  const BookingTab({super.key, required this.status, required this.bookings});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppointmentCubit, AppointmentState>(
      listener: (_, state) {
        if (state is CancelBooking) {}
      },
      builder: (_, state) {
        if (state is AppointmentLoading) {
          return const LoadingIndicator();
        } else if (state is AppointmentFailure) {
          return Center(
            child: Text(
              "Oops... Can't loading bookings for now, Please try later!",
              style: context.regular14,
            ),
          );
        } else if (state is AppointmentInitial) {
          return const SizedBox();
        } else if (bookings.isEmpty) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Iconsax.calendar_1, size: 42.sp),
              SizedBox(height: 2.h),
              Text("No $status Bookings for Now"),
            ],
          );
        } else {
          return ListView.separated(
            itemCount: bookings.length,
            separatorBuilder: (_, __) => SizedBox(height: 1.5.h),
            padding: EdgeInsets.only(
              top: 1.h,
              left: 4.w,
              right: 4.w,
              bottom: 2.h,
            ),
            itemBuilder: (_, index) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (index == 0 &&
                      (status == "Canceled" || status == "Completed"))
                    Padding(
                      padding: EdgeInsets.only(
                        top: 1.h,
                        left: 4.w,
                        right: 4.h,
                        bottom: 4.h,
                      ),
                      child: Text(
                        "Hint: $status Bookings are automatically deleted after a week.",
                        style: context.regular14?.copyWith(
                          color: ConstColor.icon.color,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  BookingCard(
                    booking: bookings[index],
                    buttons: ActionButtons(
                      status: status,
                      bookingId: index,
                      bookings: bookings,
                    ),
                  ),
                ],
              );
            },
          );
        }
      },
    );
  }
}
