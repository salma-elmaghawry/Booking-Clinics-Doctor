import 'package:booking_clinics_doctor/core/constant/const_color.dart';
import 'package:booking_clinics_doctor/core/constant/extension.dart';
import 'package:booking_clinics_doctor/features/auth/ui/widgets/logo_header.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../widgets/signup_form.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Align(
          alignment: const Alignment(0, -0.5),
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
            children: [
              const LogoHeader(),
              Text(
                "Create Account",
                textAlign: TextAlign.center,
                style: context.semi20,
              ),
              SizedBox(height: 0.5.h),
              Text(
                "We are here to help you",
                textAlign: TextAlign.center,
                style: context.regular14?.copyWith(
                  color: ConstColor.icon.color,
                ),
              ),
              SizedBox(height: 4.h),
              // Form
              const SignupForm(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Register in Hagzy?",
                    style: context.medium14?.copyWith(
                      color: ConstColor.icon.color,
                    ),
                  ),
                  TextButton(
                    onPressed: () => context.nav.pop(),
                    child: Text(
                      "Sign In",
                      style: context.medium14?.copyWith(
                        color: ConstColor.primary.color,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
