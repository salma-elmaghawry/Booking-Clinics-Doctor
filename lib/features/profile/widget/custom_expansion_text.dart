import 'package:booking_clinics_doctor/core/constant/extension.dart';
import 'package:flutter/material.dart';

import '../../../core/constant/const_color.dart';

class CustomExpansionText extends StatelessWidget {
  const CustomExpansionText({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      "Aliquip magna aute do esse est consequat commodo nulla voluptate.",
      style: context.regular14?.copyWith(
        color: ConstColor.icon.color,
      ),
    );
  }
}