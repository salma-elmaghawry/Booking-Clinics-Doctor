import 'package:booking_clinics_doctor/core/constant/extension.dart';
import 'package:booking_clinics_doctor/core/constant/images_path.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/common/custom_network_img.dart';
import '../../../../core/constant/const_string.dart';

class ReviewsItem extends StatelessWidget {
  const ReviewsItem({
    super.key,
    this.image,
    this.name = 'Emily Anderson',
    this.rating = '4.5',
    this.review = ConstString.reviewFakeText,
  });

  final String? image;
  final String name;
  final String rating;
  final String review;

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: Colors.black12,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomNetworkImage(
                  imageUrl: image,
                  height: 7.5.h,
                  width: 7.5.h,
                  fallbackAsset: MyImages.boyAvatar,
                  borderRadius: 50,
                ),
                SizedBox(width: 3.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: context.semi16,
                    ),
                    Row(
                      children: [
                        const Icon(Icons.star_rounded, color: Colors.orangeAccent),
                        Text(rating, style: context.regular14),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 1.h),
            Text(
              review,
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.start,
              style: context.regular14,
            ),
          ],
        ),
      ),
    );
  }
}
