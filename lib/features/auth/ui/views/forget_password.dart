import 'package:booking_clinics_doctor/core/constant/extension.dart';
import 'package:booking_clinics_doctor/core/helper/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/common/input.dart';
import '../../../../core/constant/const_color.dart';
import '../../data/auth_services.dart';
import '../widgets/custom_elevated_button.dart';
import '../widgets/logo_header.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 6.w),
          children: [
            const LogoHeader(),
            Text(
              textAlign: TextAlign.center,
              "Forget Password?",
              style: context.semi20,
            ),
            SizedBox(height: 1.h),
            Text(
              "Enter your Email, we will send you a verification code.",
              style: context.regular14?.copyWith(
                color: ConstColor.icon.color,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8.h),
            Input(
              hint: "Your Email",
              prefix: Iconsax.sms,
              controller: _emailController,
            ),
            SizedBox(height: 3.h),
            _isLoading
                ? const CircularProgressIndicator()
                : CustomElevatedButton(
                    title: "Verify",
                    onPressed: _resetPassword,
                  ),
          ],
        ),
      ),
    );
  }

  void _resetPassword() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      await getIt
          .get<AuthenticationServices>()
          .resetPassword(_emailController.text.trim())
          .then((_) => context.nav.pop());
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Password Reset Email Sent'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }
}
