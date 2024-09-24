import 'package:booking_clinics/core/constant/const_color.dart';
import 'package:booking_clinics/core/constant/extension.dart';
import 'package:booking_clinics/feature/Auth/Ui/widgets/socilal_button.dart';
import 'package:booking_clinics/feature/auth/ui/widgets/logo_header.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../widgets/or_divider.dart';
import '../widgets/signup_form.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
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
              SizedBox(height: 1.h),
              Text(
                "We are here to help you",
                textAlign: TextAlign.center,
                style: context.regular14?.copyWith(
                  color: ConstColor.icon.color,
                ),
              ),
              SizedBox(height: 3.h),
              // Form
              const SignupForm(),
              SizedBox(height: 2.h),
              const OrDivider(),
              SizedBox(height: 2.h),
              const SocialButton(
                  iconUrl: "assets/icons/Google - Original.svg",
                  title: "Continue with Google"),
              SizedBox(height: 1.h),
              const SocialButton(
                  iconUrl: "assets/icons/_Facebook.svg",
                  title: "Continue with Facebook"),
              SizedBox(height: 2.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Do you have an account ? ",
                    style: context.medium14?.copyWith(
                      color: ConstColor.icon.color,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      context.nav.pop();
                    },
                    child: Text(
                      "Sign In",
                      style: context.medium14?.copyWith(
                        color: ConstColor.blue.color,
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
