import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';

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
      width: 1.5.sp,
      color: Colors.black,
    ),
    borderRadius: BorderRadius.circular(3.5.w),
  );
}
