import 'package:sizer/sizer.dart';
import '../widget/today_booking.dart';
import 'package:flutter/material.dart';

class SeeAllView extends StatelessWidget {
  const SeeAllView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Today Bookings"),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
        child: const TodayBooking(),
      ),
    );
  }
}
