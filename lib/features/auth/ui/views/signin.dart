import 'package:booking_clinics/core/constant/const_color.dart';
import 'package:booking_clinics/core/constant/const_string.dart';
import 'package:booking_clinics/core/constant/extension.dart';
import 'package:booking_clinics/feature/Auth/Ui/widgets/socilal_button.dart';
import 'package:booking_clinics/feature/auth/ui/widgets/logo_header.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../widgets/or_divider.dart';
import '../widgets/signin_form.dart';

class SignIn extends StatelessWidget {
  const SignIn({super.key});

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
                "Hi, Welcome Back! ",
                textAlign: TextAlign.center,
                style: context.semi20,
              ),
              SizedBox(height: 1.h),
              Text(
                "Hope you’re doing fine.",
                textAlign: TextAlign.center,
                style: context.regular14?.copyWith(
                  color: ConstColor.icon.color,
                ),
              ),
              SizedBox(height: 4.h),

              const SigninForm(),

              SizedBox(height: 2.h),
              const OrDivider(),
              SizedBox(height: 2.h),
              const SocialButton(
                iconUrl: "assets/icons/Google - Original.svg",
                title: "Sign In with Google",
              ),
              SizedBox(height: 1.5.h),
              const SocialButton(
                iconUrl: "assets/icons/_Facebook.svg",
                title: "Sign In with Facebook",
              ),
              SizedBox(height: 2.h),
              TextButton(
                onPressed: () => context.nav.pushNamed(Routes.forgetPassword),
                child: const Text("Forgot password?"),
              ),
              SizedBox(height: 2.h),
              // Don’t have an account yet
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don’t have an account yet?",
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: ConstColor.icon.color,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => context.nav.pushNamed(Routes.signup),
                    child: Text(
                      " Sign up",
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: ConstColor.blue.color,
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
