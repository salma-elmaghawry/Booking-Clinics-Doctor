import 'package:booking_clinics_doctor/core/constant/const_color.dart';
import 'package:booking_clinics_doctor/features/home/ui/widget/custom_linear_chart.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import '../../../../core/common/input.dart';
import 'package:booking_clinics_doctor/core/constant/extension.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.only(
        left: 6.w,
        right: 6.w,
        bottom: 2.h,
        top: MediaQuery.of(context).padding.top + 2.h,
      ),
      children: [
        ListTile(
          title: Text("Hi Omar Ali,", style: context.semi16),
          subtitle: Text(
            "Have a nice day at work",
            style: context.bold18?.copyWith(
              color: ConstColor.icon.color,
            ),
          ),
          trailing: CircleAvatar(
            radius: 8.w,
            backgroundColor: ConstColor.textBtn.color,
            child: const Icon(Iconsax.user),
          ),
        ),
        SizedBox(height: 3.h),
        const Input(
          isDense: false,
          prefix: Iconsax.search_normal,
          hint: "Search Appointment",
        ),
        // SizedBox(height: 4.h),
        // const CustomLineChart(),
        Padding(
          padding: EdgeInsets.only(top: 2.h),
          child: Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Iconsax.info_circle,
                  color: ConstColor.icon.color,
                ),
              ),
              Text(
                "Show Details",
                style: context.regular14?.copyWith(
                  color: ConstColor.icon.color,
                ),
              ),
            ],
          ),
        ),
        // const CustomBarChart(),
        const CustomLineChart(),
      ],
    );
  }
}
