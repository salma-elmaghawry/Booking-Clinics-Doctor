import 'package:booking_clinics/core/constant/const_color.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    this.suffixIcon,
    this.preIcon,
    required this.hint,
    this.onChange,
    this.controller,
    super.key,
  });

  final String hint;
  final Widget? preIcon;
  final Widget? suffixIcon;
  final Function(String)? onChange;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 400,
      height: 60,
      child: TextFormField(
        controller: controller,
        validator: (value) => value!.isEmpty ? 'Can not be Empty' : null,
        style: TextStyle(fontSize: 15.sp, color: MyColors.dark),
        onChanged: onChange,
        // Make sure onChange is called
        cursorColor: const Color(0xff6B7280),
        decoration: InputDecoration(
          prefixIcon: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 1.5.w,
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
              child: preIcon,
            ),
          ),
          filled: true,
          suffixIcon: suffixIcon != null
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: suffixIcon,
                )
              : null,
          prefixIconConstraints:
              const BoxConstraints(minHeight: 40, minWidth: 30),
          prefixIconColor: const Color(0xff9CA3AF),
          suffixIconColor: const Color(0xff9CA3AF),
          hintText: hint,
          hintStyle: const TextStyle(fontSize: 14, color: Color(0xff9CA3AF)),
          border: buildBorder(),
          enabledBorder: buildBorder(),
          focusedBorder: buildFocusedBorder(),
        ),
      ),
    );
  }

  OutlineInputBorder buildBorder() {
    return OutlineInputBorder(
      borderSide: BorderSide(
        width: 0.8.sp,
        color: Colors.black12,
      ),
      borderRadius: BorderRadius.circular(3.5.w),
    );
  }

  OutlineInputBorder buildFocusedBorder() {
    return OutlineInputBorder(
      borderSide: BorderSide(
        width: 0.8.sp,
        color: Colors.deepPurple,
      ),
      borderRadius: BorderRadius.circular(3.5.w),
    );
  }
}

// Example usage
