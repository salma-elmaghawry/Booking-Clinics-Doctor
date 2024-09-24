import 'package:booking_clinics/core/constant/const_color.dart';
import 'package:booking_clinics/core/constant/extension.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class OrDivider extends StatelessWidget {
  const OrDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 5.w),
            child: Divider(color: ConstColor.icon.color),
          ),
        ),
        Text(
          "or",
          style: context.medium16?.copyWith(color: ConstColor.icon.color),
        ),
        Expanded(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 5.w),
            child: Divider(color: ConstColor.icon.color),
          ),
        ),
      ],
    );
  }
}
