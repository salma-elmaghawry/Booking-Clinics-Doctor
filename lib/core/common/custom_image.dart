import 'package:booking_clinics_doctor/core/constant/images_path.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CustomImage extends StatelessWidget {
  final String? image;
  final Widget? errorWidget;
  const CustomImage({super.key, this.errorWidget, this.image});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20.w),
      child: CachedNetworkImage(
        imageUrl: image ?? "",
        width: 20.w,
        height: 20.w,
        fit: BoxFit.cover,
        placeholder: (_, url) => SizedBox(
          height: 20.w,
          // width: double.infinity,
        ),
        errorWidget: (_, url, error) =>
            errorWidget ??
            Image.asset(
              MyImages.doctorAvatar,
              fit: BoxFit.cover,
            ),
        errorListener: null,
      ),
    );
  }
}
