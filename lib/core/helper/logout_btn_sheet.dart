import 'package:booking_clinics_doctor/core/constant/const_string.dart';
import 'package:booking_clinics_doctor/core/constant/extension.dart';
import 'package:sizer/sizer.dart';
import '../../data/services/remote/firebase_auth.dart';
import '../common/custom_button.dart';
import '../constant/const_color.dart';
import 'package:flutter/material.dart';

class LogoutBottomSheet extends StatelessWidget {
  const LogoutBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(6.w, 0, 6.w, 3.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Logout",
            style: context.semi20?.copyWith(
              color: ConstColor.icon.color,
            ),
          ),
          Divider(height: 4.h),
          Text("Are you sure you want to log out?", style: context.semi16),
          SizedBox(height: 3.h),
          Row(
            children: [
              Flexible(
                child: CustomButton(
                  text: 'Cancel',
                  textColor: Colors.black,
                  borderRadius: 3.5.w,
                  color: MyColors.gray,
                  textSize: context.bold14?.fontSize,
                  onTap: () => context.nav.pop(),
                ),
              ),
              SizedBox(width: 4.w),
              Flexible(
                child: CustomButton(
                  text: 'Yes, Logout',
                  borderRadius: 3.5.w,
                  textSize: context.bold14?.fontSize,
                  onTap: () {
                    FirebaseAuthService().signOut();
                    context.nav.pushNamedAndRemoveUntil(
                      Routes.signin,
                      (route) => false,
                    );
                  },
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
