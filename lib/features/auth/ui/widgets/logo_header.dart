import 'package:booking_clinics_doctor/core/constant/const_color.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class LogoHeader extends StatelessWidget {
  const LogoHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Column(
      children: [
        SizedBox(height: 2.h),
        Image.asset(
          isDark ? 'assets/images/logo_white.png' : 'assets/images/logo.png',
          height: 66,
          width: 66,
        ),
        SizedBox(height: 2.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Health",
              style: TextStyle(
                fontSize: 20.sp,
                color: ConstColor.icon.color,
              ),
            ),
            Text("Pal", style: TextStyle(fontSize: 20.sp)),
          ],
        ),
        SizedBox(height: 2.h),
      ],
    );
  }
}
