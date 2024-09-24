import 'package:booking_clinics/core/common/input.dart';
import 'package:booking_clinics/core/common/profile_image.dart';
import 'package:booking_clinics/core/constant/extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sizer/sizer.dart';
import '../../../profile/ui/image_manager/pick_image_cubit.dart';
import '../../../profile/ui/profile_manager/profile_cubit.dart';

class EditYourProfile extends StatefulWidget {
  const EditYourProfile({super.key});

  @override
  State<EditYourProfile> createState() => _EditYourProfileState();
}

class _EditYourProfileState extends State<EditYourProfile> {
  late TextEditingController _nameController;
  late TextEditingController emailController;
  late TextEditingController _phoneController;
  late TextEditingController _birthController;
  late GlobalKey<FormState> _formState;

  @override
  void initState() {
    super.initState();
    context.read<ProfileCubit>().getUserData();
    _nameController = TextEditingController();
    emailController = TextEditingController();
    _phoneController = TextEditingController();
    _birthController = TextEditingController();
    _formState = GlobalKey<FormState>();
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    emailController.dispose();
    _phoneController.dispose();
    _birthController.dispose();
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
              SizedBox(height: 8.h),
              Input(
                enabled: false,
                prefix: Iconsax.sms,
                hint: "mail@example.com",
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
                hint: "Date of Birth",
                prefix: Iconsax.calendar,
                controller: _birthController,
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
    if (_birthController.text.trim().isNotEmpty) {
      data["birth_date"] = _birthController.text.trim();
    }
    if (cubit.downLoadUrl != null) {
      data["profile_image"] = cubit.downLoadUrl;
    }
    if (data.isEmpty && cubit.image == null) return;
    await cubit.updateUserData(data);
    if (cubit.state is UpdateProfileSuccess) {
      _nameController.clear();
      _phoneController.clear();
      _birthController.clear();
      await cubit.getUserData();
    }
  }
}
