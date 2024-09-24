import 'package:booking_clinics_doctor/core/constant/const_string.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:booking_clinics_doctor/core/constant/extension.dart';
import '../../../../core/constant/const_color.dart';

class Categories extends StatelessWidget {
  const Categories({super.key});

  static const List<String> _images = [
    "assets/images/category_2.svg",
    "assets/images/category_3.svg",
    "assets/images/category_1.svg",
    "assets/images/category_4.svg",
    "assets/images/category_6.svg",
    "assets/images/category_8.svg",
    "assets/images/category_7.svg",
    "assets/images/category_5.svg",
  ];

  static const List<String> _categories = [
    "All",
    "Dentistry",
    "Cardiologist",
    "Dermatology",
    "Pediatrics",
    "Orthopedics",
    "Neurology",
    "Psychiatry",
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 13.h,
      child: ListView.separated(
        shrinkWrap: true,
        itemCount: _categories.length,
        padding: EdgeInsets.symmetric(horizontal: 4.w),
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, index) {
          return GestureDetector(
            onTap: () {
              context.nav.pushNamed(Routes.seeAll, arguments: index);
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(5.2.w),
                  child: SvgPicture.asset(_images[index], width: 18.w),
                ),
                SizedBox(height: 0.75.h),
                Text(
                  _categories[index],
                  maxLines: 1,
                  style: context.bold12?.copyWith(
                    fontSize: 12.5.sp,
                    color: ConstColor.icon.color,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          );
        },
        separatorBuilder: (_, index) => SizedBox(width: 4.w),
      ),
    );
  }
}
