import 'package:booking_clinics_doctor/core/constant/extension.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/common/custom_network_img.dart';
import '../../../../core/constant/const_color.dart';
import '../../../../core/constant/images_path.dart';

Widget buildBookingCard(
  BuildContext context, {
  required String date, time, doctorName, specialization,clinic,imageUrl,
  required Widget buttons,
}) {
  return Card(
    child: Padding(
      padding: EdgeInsets.all(3.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(date, style: context.semi14),
              SizedBox(width: 3.h),
              Text(time, style: context.semi14),
            ],
          ),
          Divider(height: 3.h),
          Row(
            children: [
              CustomNetworkImage(
                imageUrl: imageUrl,
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
                        doctorName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: context.bold16,
                      ),
                      SizedBox(height: 2.w),
                      // Specialization
                      Text(specialization, style: context.regular14),
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
                              clinic,
                              style: const TextStyle(color: MyColors.softGray),
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
          Divider(height: 3.h),
          buttons,
        ],
      ),
    ),
  );
}
