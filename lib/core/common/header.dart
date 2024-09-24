import 'package:booking_clinics/core/constant/extension.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class Header extends StatelessWidget {
  const Header({
    super.key,
    this.hasSeeAll,
    required this.title,
    required this.subtitle,
  });
  final bool? hasSeeAll;
  final String title, subtitle;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      contentPadding: EdgeInsets.only(left: 4.w, right: 4.w, top: 1.5.h),
      title: Text(title, style: context.bold16),
      subtitle: Text(subtitle, style: context.regular14),
      trailing: hasSeeAll ?? false
          ? TextButton(
              onPressed: () {},
              child: const Text("See All"),
            )
          : null,
    );
  }
}
