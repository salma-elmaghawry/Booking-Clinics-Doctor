import 'package:booking_clinics_doctor/core/constant/const_color.dart';
import 'package:booking_clinics_doctor/core/constant/const_string.dart';
import 'package:booking_clinics_doctor/core/constant/extension.dart';
import 'package:booking_clinics_doctor/features/auth/ui/widgets/logo_header.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../widgets/signin_form.dart';

class SignIn extends StatelessWidget {
  const SignIn({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Align(
          alignment: const Alignment(0, -.5),
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
            children: [
              const LogoHeader(),
              Text(
                "Hi, Welcome Back!",
                textAlign: TextAlign.center,
                style: context.semi20,
              ),
              SizedBox(height: 0.5.h),
              Text(
                "Hope you’re doing fine",
                textAlign: TextAlign.center,
                style: context.regular14?.copyWith(
                  color: ConstColor.icon.color,
                ),
              ),
              SizedBox(height: 8.h),

              const SigninForm(),

              // Don’t have an account yet
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account yet?",
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: ConstColor.icon.color,
                    ),
                  ),
                  TextButton(
                    onPressed: () => context.nav.pushNamed(Routes.signup),
                    child: Text(
                      "Sign up",
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: ConstColor.primary.color,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
