import 'package:booking_clinics_doctor/core/constant/const_color.dart';
import 'package:booking_clinics_doctor/core/constant/const_string.dart';
import 'package:booking_clinics_doctor/core/constant/extension.dart';
import 'package:flutter/material.dart';

class ListHeader extends StatelessWidget {
  final String title;
  const ListHeader({required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: context.bold16?.copyWith(
            color: ConstColor.icon.color,
          ),
        ),
        TextButton(
          onPressed: () {
            context.nav.pushNamed(Routes.seeAll);
          },
          child: const Text("See All"),
        ),
      ],
    );
  }
}
