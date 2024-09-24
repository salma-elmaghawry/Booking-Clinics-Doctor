import 'package:booking_clinics/core/constant/const_color.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CustomCongAuthDialog extends StatelessWidget {
  const CustomCongAuthDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 26, 20, 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset("assets/images/success_dialog.png",
                height: 35.w, width: 35.w),
            SizedBox(height: 4.w),
            Text(
              'Congratulations!',
              style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: MyColors.dark),
            ),
            SizedBox(height: 3.w),
            Text(
              "Your account is ready to use. You will be redirected to the Home Page in a few seconds...",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15.5.sp, color: Colors.grey),
            ),
            SizedBox(height: 5.w),
            Icon(Icons.done_outline, color: ConstColor.primary.color),
          ],
        ),
      ),
    );
  }
}
