import 'package:booking_clinics/core/constant/const_string.dart';
import 'package:sizer/sizer.dart';
import '../../data/services/remote/firebase_auth.dart';
import '../common/custom_button.dart';
import '../constant/const_color.dart';
import 'package:flutter/material.dart';
import 'package:booking_clinics/core/constant/extension.dart';

class LogoutBottomSheet extends StatelessWidget {
  const LogoutBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDarkTheme = MediaQuery.of(context).platformBrightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(25),

      decoration: BoxDecoration(
        color: isDarkTheme? MyColors.dark : Colors.white,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("Logout", style: context.semi20),
          Divider(color: ConstColor.secondary.color, height: 4.h),
          Text(
            "Are you sure you want to log out?",
            style: context.semi16?.copyWith(
              color: ConstColor.icon.color,
            ),
          ),
          SizedBox(height: 3.h),
          Row(
            children: [
              Flexible(
                child: CustomButton(
                  text: 'Cancel',
                  textColor: Colors.black,
                  color: MyColors.gray,
                  borderRadius: 3.5.w,
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
