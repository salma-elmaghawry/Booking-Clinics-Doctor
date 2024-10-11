import 'package:booking_clinics_doctor/core/common/dropdown.dart';
import 'package:booking_clinics_doctor/core/constant/const_color.dart';
import 'package:booking_clinics_doctor/core/constant/const_string.dart';
import 'package:booking_clinics_doctor/core/constant/extension.dart';
import 'package:booking_clinics_doctor/core/helper/service_locator.dart';
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

  bool _isLoading = false;
  String? selectedSpeciality;
  // final AuthenticationServices _authServices = AuthenticationServices();
  bool _locationObtained = false;
  final Map<String, dynamic> location = {};

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    nameController.dispose();
    passwordController.dispose();
    specialityController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formState,
      child: Column(
        children: [
          // specialty
          Material(
            color: ConstColor.iconDark.color,
            borderRadius: BorderRadius.circular(3.5.w),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(width: 4.w),
                const Icon(Iconsax.sort),
                Expanded(
                  child: DropDown(
                    isDense: false,
                    isExpanded: true,
                    titles: ConstString.specialties,
                    onSelect: (val) {
                      selectedSpeciality = ConstString.specialties[val ?? 0];
                      specialityController.text = "$selectedSpeciality";
                    },
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 1.5.h),
          // Name
          Input(
            hint: "Full Name",
            prefix: Iconsax.user,
            controller: nameController,
          ),
          SizedBox(height: 1.5.h),
          // Email
          Input(
            hint: "Valid Email",
            prefix: Iconsax.sms,
            controller: emailController,
          ),
          SizedBox(height: 1.5.h),
          // Password
          Row(
            children: [
              Expanded(
                child: Input(
                  hint: "Password",
                  controller: passwordController,
                ),
              ),
              SizedBox(width: 4.w),
              Expanded(
                child: Input(
                  hint: "Confirm",
                  controller: passwordController,
                ),
              ),
            ],
          ),
          SizedBox(height: 1.5.h),
          // Location Section
          Material(
            color: ConstColor.iconDark.color,
            borderRadius: BorderRadius.circular(3.5.w),
            child: Padding(
              padding: EdgeInsets.only(left: 4.w, right: 2.w),
              child: Row(
                children: [
                  const Icon(Iconsax.location),
                  SizedBox(width: 4.w),
                  Text(
                    _locationObtained
                        ? 'Location Obtained'
                        : 'Medical Center Location',
                    style: context.regular14?.copyWith(
                      color: ConstColor.icon.color,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: _getLocation,
                    icon: Icon(
                      Icons.my_location,
                      color: ConstColor.primary.color,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 4.h),

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

      User? user =
          await getIt.get<AuthenticationServices>().signUpWithEmailAndPassword(
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
        await getIt.get<AuthenticationServices>().addDoctorFireStore(newDoctor);
        setState(() => _isLoading = false);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Verify your email',
              style: context.regular14,
            ),
            backgroundColor: ConstColor.primary.color,
          ),
        );
        context.nav.pushNamedAndRemoveUntil(Routes.signin, (route) => false);
      } else {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Sign Up Failed, Please Try Later.',
              style: context.regular14,
            ),
            backgroundColor: ConstColor.primary.color,
          ),
        );
      }
    }
  }

  Future<void> _getLocation() async {
    setState(() => _isLoading = true);
    try {
      final userLocation =
          await getIt.get<AuthenticationServices>().getUserLocation();
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
