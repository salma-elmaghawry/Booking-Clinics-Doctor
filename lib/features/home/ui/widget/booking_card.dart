import 'package:booking_clinics_doctor/core/constant/extension.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/common/custom_image.dart';
import '../../../../core/constant/const_color.dart';
import '../../../../data/models/booking.dart';

class BookingCard extends StatelessWidget {
  final Booking booking;
  const BookingCard({required this.booking, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Card(
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
