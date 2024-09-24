import 'package:booking_clinics/core/constant/const_string.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:booking_clinics/core/constant/extension.dart';

class ListHeader extends StatelessWidget {
  final String title;
  const ListHeader({required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 1.5.h, left: 4.w, right: 4.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: context.bold16),
          TextButton(
            onPressed: () {
              context.nav.pushNamed(Routes.seeAll);
            },
            child: const Text("See All"),
          ),
        ],
      ),
    );
  }
}
