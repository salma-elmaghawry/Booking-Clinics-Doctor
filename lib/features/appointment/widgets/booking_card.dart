import 'package:booking_clinics_doctor/core/constant/extension.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../../core/common/custom_network_img.dart';
import '../../../core/constant/const_color.dart';
import '../../../core/constant/images_path.dart';
import '../../../data/models/booking.dart';

class BookingCard extends StatelessWidget {
  final Widget buttons;
  final Booking booking;
  const BookingCard({required this.booking, required this.buttons, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(4.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IntrinsicHeight(
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 2.w,
                      vertical: 0.5.h,
                    ),
                    decoration: BoxDecoration(
                        gradient: booking.isAccepted < 0
                            ? orangeToRedGradient
                            : booking.isAccepted > 0
                                ? blueToPurpleGradient
                                : greenToTealGradient,
                        borderRadius: BorderRadius.circular(4.w)),
                    child: Text(
                      booking.isAccepted < 0
                          ? "rejected"
                          : booking.isAccepted > 0
                              ? "accepted"
                              : "in progress",
                      style: context.regular14?.copyWith(
                        // height: 0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Text(booking.time, style: context.semi14),
                  VerticalDivider(width: 4.w),
                  Text(booking.date, style: context.semi14),
                ],
              ),
            ),
            Divider(height: 4.h),
            Row(
              children: [
                CustomNetworkImage(
                  imageUrl: booking.imageUrl,
                  fallbackAsset: MyImages.doctorAvatar,
                  height: 35.w,
                  width: 35.w,
                  borderRadius: 3.w,
                ),
                SizedBox(width: 1.w),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 2.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Doctor Name
                        Text(
                          booking.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: context.bold16,
                        ),
                        SizedBox(height: 2.w),
                        // Specialization
                        Text(booking.specialty, style: context.regular14),
                        SizedBox(height: 1.w),
                        // Clinic
                        Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              color: MyColors.softGray,
                              size: 2.h,
                            ),
                            Expanded(
                              child: Text(
                                booking.address,
                                style:
                                    const TextStyle(color: MyColors.softGray),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 2.h),
            // Divider(height: 3.h),
            buttons,
          ],
        ),
      ),
    );
  }
}
