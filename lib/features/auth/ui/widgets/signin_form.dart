import 'package:booking_clinics/core/common/input.dart';
import 'package:booking_clinics/core/constant/extension.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/constant/const_string.dart';
import '../../../../data/models/patient.dart';
import '../../../../data/services/local/shared_pref_storage.dart';
import '../../../../data/services/remote/firebase_auth.dart';
import '../../../../data/services/remote/firebase_firestore.dart';
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
  final FirebaseAuthService _authService = FirebaseAuthService();

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
                  title: "Create Account",
                  onPressed: _signIn,
                ),
        ],
      ),
    );
  }

  void _signIn() async {
    if (formState.currentState!.validate()) {
      setState(() => _isLoading = true);

      User? user = await _authService.loginWithEmailAndPassword(
        emailController.text.trim(),
        passwordController.text.trim(),
        context,
      );

      setState(() => _isLoading = false);
      if (user != null && user.emailVerified) {
        // fetch patient object from firestore
        Patient? patient = await FirebaseFirestoreService().getPatientById(user.uid);
        if (patient != null) {
          // save patient object in SharedPreference
          await SharedPrefServices().savePatient(patient);
          context.nav.pushNamedAndRemoveUntil(Routes.navRoute, (route) => false);
        }
      } else {
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
