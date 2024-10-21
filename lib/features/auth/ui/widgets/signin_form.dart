import 'package:booking_clinics_doctor/core/common/input.dart';
import 'package:booking_clinics_doctor/core/constant/extension.dart';
import 'package:booking_clinics_doctor/core/helper/service_locator.dart';
import 'package:booking_clinics_doctor/data/models/doctor_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/constant/const_string.dart';
import '../../../../data/services/local/shared_pref_storage.dart';
import '../../data/auth_services.dart';
import 'custom_elevated_button.dart';

class SigninForm extends StatefulWidget {
  const SigninForm({super.key});

  @override
  State<SigninForm> createState() => _SigninFormState();
}

class _SigninFormState extends State<SigninForm> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formState = GlobalKey();
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formState,
      child: Column(
        children: [
          Input(
            controller: emailController,
            prefix: Iconsax.sms,
            hint: "Your Email",
          ),
          SizedBox(height: 1.5.h),
          Input(
            controller: passwordController,
            prefix: Iconsax.lock,
            hint: "Password",
          ),
          Align(
            alignment: const Alignment(1, 0),
            child: TextButton(
              onPressed: () => context.nav.pushNamed(Routes.forgetPassword),
              child: const Text("Forgot password?"),
            ),
          ),
          SizedBox(height: 6.h),
          _isLoading
              ? const CircularProgressIndicator()
              : CustomElevatedButton(
                  title: "Login",
                  onPressed: _signIn,
                ),
        ],
      ),
    );
  }

  void _signIn() async {
    if (formState.currentState!.validate()) {
      setState(() => _isLoading = true);

      User? user =
          await getIt.get<AuthenticationServices>().loginWithEmailAndPassword(
                emailController.text.trim(),
                passwordController.text.trim(),
                context,
              );
      setState(() => _isLoading = false);

      if (user != null && user.emailVerified) {
        DoctorModel? doctor = await getIt
            .get<AuthenticationServices>()
            .getDoctorById(context, user.uid);
        if (doctor != null) {
          await SharedPrefServices().saveDoctor(doctor);
          context.nav
              .pushNamedAndRemoveUntil(Routes.navRoute, (route) => false);
        }
      } else {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Email or Password is incorrect'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}
