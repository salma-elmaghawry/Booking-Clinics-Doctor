import 'package:booking_clinics/core/common/input.dart';
import 'package:booking_clinics/core/constant/const_color.dart';
import 'package:booking_clinics/core/constant/extension.dart';
import 'package:booking_clinics/feature/Auth/Ui/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sizer/sizer.dart';
import '../../../../data/services/remote/firebase_auth.dart';
import '../widgets/logo_header.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _isLoading = false;
  final FirebaseAuthService _authService = FirebaseAuthService();

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
            SizedBox(height: 2.h),
            Text(
              "Enter your Email, we will send you a verification code.",
              style: context.regular14?.copyWith(
                color: ConstColor.icon.color,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 4.h),
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

  void _resetPassword() {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      _authService
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
