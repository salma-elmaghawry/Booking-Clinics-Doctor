import 'package:booking_clinics_doctor/core/constant/const_color.dart';
import 'package:booking_clinics_doctor/core/constant/extension.dart';
import 'package:flutter/material.dart';

class ListHeader extends StatelessWidget {
  final String title;
  final void Function()? onPressed;
  const ListHeader({required this.title, this.onPressed, super.key});

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
          onPressed: onPressed,
          child: const Text("See All"),
        ),
      ],
    );
  }
}
