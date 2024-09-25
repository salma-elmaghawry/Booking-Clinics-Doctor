import 'package:booking_clinics_doctor/core/constant/const_string.dart';
import 'package:booking_clinics_doctor/core/constant/extension.dart';
import 'package:booking_clinics_doctor/data/models/doctor_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/common/input.dart';
import '../../data/auth_services.dart';
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
  final AuthenticationServices _authServices = AuthenticationServices();
  bool _locationObtained = false;
  final Map<String, dynamic> location = {};

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
          SizedBox(height: 1.h),

          // Location Section
          Row(
            children: [
              _locationObtained
                  ? const Icon(Icons.check_circle, color: Colors.green)
                  : const Icon(Icons.location_on, color: Colors.red),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  _locationObtained ? 'Location Obtained' : 'Get Location',
                  style: context.regular14,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.my_location),
                onPressed: _getLocation,
              ),
            ],
          ),
          SizedBox(height: 3.h),

          _isLoading
              ? const CircularProgressIndicator()
              : CustomElevatedButton(
                  title: "Create Account",
                  onPressed: _locationObtained == true
                      ? _signUp
                      : () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Please get your location first"),
                              backgroundColor: Colors.red,
                            ),
                          );
                        },
                ),
        ],
      ),
    );
  }
  Future<void> _signUp() async {
    if (formState.currentState!.validate()) {
      setState(() => _isLoading = true);

      User? user = await _authServices.signUpWithEmailAndPassword(
        emailController.text.trim(),
        passwordController.text.trim(),
      );

      var speciality = specialityController.text.trim();
      if (user != null) {
        DoctorModel newDoctor = DoctorModel(
          id: user.uid,
          name: nameController.text.trim(),
          speciality: speciality.isEmpty ? 'Dentistry' : speciality,
          email: emailController.text.trim(),
          location: location,
          bookings: [],
          reviews: [],
        );
        await _authServices.addDoctorFireStore(newDoctor);
        setState(() => _isLoading = false);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Verify your email'),
            backgroundColor: Colors.green,
          ),
        );
        context.nav.pushNamedAndRemoveUntil(Routes.signin, (route) => false);
      } else {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Sign Up Failed. Please try again.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _getLocation() async {
    setState(() => _isLoading = true);

    try {
      final userLocation = await _authServices.getUserLocation();
      setState(() {
        location['lat'] = userLocation['latitude'];
        location['lng'] = userLocation['longitude'];
        _locationObtained = true;
      });
    } catch (error) {
      return Future.error(error);
    } finally {
      setState(() => _isLoading = false);
    }
  }
}
