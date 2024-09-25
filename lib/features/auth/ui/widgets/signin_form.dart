import 'package:booking_clinics_doctor/core/common/input.dart';
import 'package:booking_clinics_doctor/core/constant/extension.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/constant/const_string.dart';
import '../../../../data/models/patient.dart';
import '../../../../data/services/local/shared_pref_storage.dart';
import '../../../../data/services/remote/firebase_firestore.dart';
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
  final AuthenticationServices _authServices = AuthenticationServices();

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
          SizedBox(height: 3.h),
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

      User? user = await _authServices.loginWithEmailAndPassword(
        emailController.text.trim(),
        passwordController.text.trim(),
        context,
      );

      if (user != null && user.emailVerified) {
        Patient? patient = await FirebaseFirestoreService().getPatientById(user.uid);
        if (patient != null) {
          await SharedPrefServices().savePatient(patient);

          setState(() => _isLoading = false);
          context.nav.pushNamedAndRemoveUntil(Routes.navRoute, (route) => false);
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
