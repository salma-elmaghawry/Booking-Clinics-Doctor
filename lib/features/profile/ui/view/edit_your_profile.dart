import 'package:booking_clinics_doctor/core/constant/extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/common/input.dart';
import '../../../../core/common/profile_image.dart';
import '../image_manager/pick_image_cubit.dart';
import '../profile_manager/profile_cubit.dart';

class EditYourProfile extends StatefulWidget {
  const EditYourProfile({super.key, this.email});

  final String? email;

  @override
  State<EditYourProfile> createState() => _EditYourProfileState();
}

class _EditYourProfileState extends State<EditYourProfile> {
  late TextEditingController _nameController;
  late TextEditingController emailController;
  late TextEditingController _phoneController;
  late TextEditingController _workingHoursController;
  late TextEditingController _addressController;
  late TextEditingController _aboutController;
  late TextEditingController _experienceController;
  late TextEditingController _specialityController;
  late GlobalKey<FormState> _formState;

  String? selectedSpeciality;

  @override
  void initState() {
    super.initState();
    context.read<ProfileCubit>().getUserData();
    _nameController = TextEditingController();
    emailController = TextEditingController();
    _phoneController = TextEditingController();
    _workingHoursController = TextEditingController();
    _addressController = TextEditingController();
    _aboutController = TextEditingController();
    _experienceController = TextEditingController();
    _specialityController = TextEditingController();
    _formState = GlobalKey<FormState>();
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    emailController.dispose();
    _phoneController.dispose();
    _workingHoursController.dispose();
    _formState.currentState?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ProfileCubit cubit = context.read<ProfileCubit>();
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Fill your Profile"),
        leading: BackButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
          ),
        ),
      ),
      body: Form(
        key: _formState,
        child: Align(
          alignment: const Alignment(0, -0.75),
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BlocConsumer<PickImageCubit, PickImageState>(
                    listener: (_, state) {
                      if (state is PickImageSuccess) {
                        context.read<ProfileCubit>().image = state.image;
                      }
                    },
                    builder: (_, state) {
                      if (state is PickImageSuccess) {
                        return ProfileImage(
                          image: FileImage(state.image),
                          onTap: () async {
                            await context
                                .read<PickImageCubit>()
                                .pickImageFromGallery();
                          },
                        );
                      } else {
                        return ProfileImage(
                          onTap: () async {
                            await context
                                .read<PickImageCubit>()
                                .pickImageFromGallery();
                          },
                        );
                      }
                    },
                  ),
                ],
              ),
              SizedBox(height: 4.h),
              Input(
                enabled: false,
                prefix: Iconsax.sms,
                hint: widget.email,
                controller: emailController,
              ),
              SizedBox(height: 1.5.h),
              Input(
                hint: "Full Name",
                prefix: Iconsax.user,
                controller: _nameController,
              ),
              SizedBox(height: 1.5.h),
              Input(
                hint: "Phone Number",
                prefix: Iconsax.mobile,
                controller: _phoneController,
              ),
              SizedBox(height: 1.5.h),
              Input(
                //hint: "Date of Birth",
                hint: "Working hours",
                prefix: Iconsax.clock,
                controller: _workingHoursController,
              ),
              SizedBox(height: 1.5.h),
              Input(
                hint: "About",
                prefix: Iconsax.message_text_14,
                controller: _aboutController,
              ),
              SizedBox(height: 1.5.h),
              Input(
                hint: "Experience Years",
                prefix: Icons.work_history_outlined,
                controller: _experienceController,
              ),
              SizedBox(height: 1.5.h),
              // Speciality
              Input(
                hint: "Select Speciality",
                controller: _specialityController,
                prefix: Iconsax.hospital,
                readOnly: true,
                suffix: DropdownButton<String>(
                  value: selectedSpeciality,
                  hint: const Text("Speciality"),
                  onChanged: (String? newValue) {
                    selectedSpeciality = newValue;
                    _specialityController.text = selectedSpeciality!;
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
              // address
              Input(
                hint: "Address",
                prefix: Iconsax.home_1,
                controller: _addressController,
              ),
              SizedBox(height: 4.h),

              BlocListener<ProfileCubit, ProfileState>(
                listener: (context, state) {
                  if (state is UpdateProfileSuccess) {
                    successDialog(context);
                  }
                },
                child: ElevatedButton(
                  onPressed: () async {
                    await _onClick(cubit, context);
                  },
                  child: context.watch<ProfileCubit>().state
                          is UpdateProfileLoading
                      ? const CircularProgressIndicator(
                          color: Colors.black,
                        )
                      : const Text("Update"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void successDialog(BuildContext context) {
    showDialog(
      // barrierDismissible: true,
      context: context,
      builder: (s) {
        return Dialog(
          alignment: Alignment.center,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(
                  "assets/images/success.svg",
                  width: 35.w,
                  height: 35.w,
                ),
                SizedBox(height: 2.h),
                Text("Update Successful", style: context.bold18),
                SizedBox(height: 1.h),
                Text(
                  "Your profile has been updated successfully!",
                  textAlign: TextAlign.center,
                  style: context.regular14,
                ),
                SizedBox(height: 4.h),
                ElevatedButton(
                  onPressed: () {
                    context.nav.pop();
                  },
                  child: const Text("Done"),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _onClick(ProfileCubit cubit, BuildContext context) async {
    if (cubit.image != null) await cubit.uploadImage();

    Map<String, dynamic> data = {};
    if (_nameController.text.trim().isNotEmpty) {
      data["name"] = _nameController.text.trim();
    }
    if (_phoneController.text.trim().isNotEmpty) {
      data["phone"] = _phoneController.text.trim();
    }
    if (_aboutController.text.trim().isNotEmpty) {
      data["about"] = _aboutController.text.trim();
    }
    if (_addressController.text.trim().isNotEmpty) {
      data["address"] = _addressController.text.trim();
    }
    if (_workingHoursController.text.trim().isNotEmpty) {
      data["workingHours"] = _workingHoursController.text.trim();
    }
    if (_specialityController.text.trim().isNotEmpty) {
      data["speciality"] = _specialityController.text.trim();
    }
    if (cubit.downLoadUrl != null) {
      data["imageUrl"] = cubit.downLoadUrl;
    }
    if (data.isEmpty && cubit.image == null) return;
    await cubit.updateUserData(data);
    if (cubit.state is UpdateProfileSuccess) {
      _nameController.clear();
      _phoneController.clear();
      _workingHoursController.clear();
      _addressController.clear();
      _aboutController.clear();
      _experienceController.clear();
      _specialityController.clear();
      await cubit.getUserData();
    }
  }
}
