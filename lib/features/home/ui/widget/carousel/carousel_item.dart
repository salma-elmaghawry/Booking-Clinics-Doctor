import 'package:booking_clinics_doctor/core/constant/const_color.dart';
import 'package:booking_clinics_doctor/core/constant/extension.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';

class CarouselItem extends StatelessWidget {
  final String image;
  const CarouselItem({required this.image, super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.hardEdge,
      children: [
        Positioned(
          child: Image.asset(
            image,
            fit: BoxFit.fill,
            width: double.infinity,
            height: double.infinity,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 4.w),
          child: SizedBox(
            width: 52.w,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Looking for a Specialist doctor!",
                  style: context.bold18?.copyWith(
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 2.h),
                TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: ConstColor.main.color,
                    textStyle: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  child: const Text("Schedule Now"),
                ),
                // Text(
                //   "Schedule an appointment with our top doctors.",
                //   style: context.regular14?.copyWith(
                //     color: Colors.white,
                //   ),
                // ),
              ],
            ),
          ),
        ),
        Positioned(
          top: -19.w,
          left: -14.w,
          child: CircleAvatar(
            radius: 25.w,
            backgroundColor: Colors.white12,
          ),
        ),
        Positioned(
          left: 15.w,
          bottom: -18.w,
          child: CircleAvatar(
            radius: 12.w,
            backgroundColor: Colors.white12,
          ),
        ),
      ],
    );
  }
}
