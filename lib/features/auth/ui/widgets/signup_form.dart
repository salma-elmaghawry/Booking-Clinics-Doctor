import 'package:booking_clinics_doctor/core/constant/const_string.dart';
import 'package:booking_clinics_doctor/core/constant/extension.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/common/input.dart';
import '../../../../data/models/patient.dart';
import '../../../../data/services/remote/firebase_auth.dart';
import '../../../../data/services/remote/firebase_firestore.dart';
import 'custom_elevated_button.dart';

class SignupForm extends StatefulWidget {
  const SignupForm({super.key});

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final TextEditingController specialityController = TextEditingController();
  GlobalKey<FormState> formState = GlobalKey();

  String? selectedSpeciality;
  bool _isLoading = false;
  final FirebaseAuthService _authService = FirebaseAuthService();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formState,
      child: Column(
        children: [
          // Name
          Input(
            hint: "Your Name",
            prefix: Iconsax.user,
            controller: nameController,
          ),
          SizedBox(height: 1.5.h),
          // Speciality
          Input(
            hint: "Select Speciality",
            controller: specialityController,
            prefix: Iconsax.hospital,
            readOnly: true,
            suffix: DropdownButton<String>(
              value: selectedSpeciality,
              hint: const Text("Speciality"),
              onChanged: (String? newValue) {
                selectedSpeciality = newValue;
                specialityController.text = selectedSpeciality!;
              },
              items: [
                "Dentistry",
                "Cardiologist",
                "Dermatology",
                "Pediatrics",
                "Orthopedics",
                "Neurology",
                "Psychiatry",
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value, style: context.regular14),
                );
              }).toList(),
            ),
          ),
          SizedBox(height: 1.5.h),
          // Email
          Input(
            hint: "Your Email",
            prefix: Iconsax.sms,
            controller: emailController,
          ),
          SizedBox(height: 1.5.h),
          // Password
          Input(
            hint: "Password",
            prefix: Iconsax.lock,
            controller: passwordController,
          ),
          SizedBox(height: 3.h),

          _isLoading
              ? const CircularProgressIndicator()
              : CustomElevatedButton(
                  title: "Create Account",
                  onPressed: _signUp,
                ),
        ],
      ),
    );
  }

  void _signUp() async {
    if (formState.currentState!.validate()) {
      setState(() => _isLoading = true);

      User? user = await _authService.signUpWithEmailAndPassword(
        emailController.text.trim(),
        passwordController.text.trim(),
      );

      setState(() => _isLoading = false);

      if (user != null) {
        // Create a new Patient object
        Patient newPatient = Patient(
          uid: user.uid,
          name: nameController.text.trim(),
          email: emailController.text.trim(),
          phone: '',
          birthDate: '',
          profileImg: '',
          bookings: [],
          favorites: [],
        );

        // Save the patient object to Firestore
        FirebaseFirestoreService firestoreService = FirebaseFirestoreService();
        await firestoreService.addPatient(newPatient);

        context.nav.pushNamedAndRemoveUntil(Routes.signin, (route) => false);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Sign Up Failed. Please try again.____'),
          ),
        );
      }
    }
  }
}
