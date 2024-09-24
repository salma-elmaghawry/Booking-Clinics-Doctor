import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';

TextTheme textTheme() {
  return TextTheme(
    // * _____ Headline [semi20]-[bold18]-[bold16] _____ * //
    headlineLarge: TextStyle(
      fontSize: 20.sp,
      fontWeight: FontWeight.w600,
    ),
    headlineMedium: TextStyle(
      fontSize: 18.sp,
      fontWeight: FontWeight.bold,
    ),
    headlineSmall: TextStyle(
      fontSize: 16.sp,
      letterSpacing: 0.2,
      fontWeight: FontWeight.bold,
    ),
    // * _____ Title [semi16]-[medium16]-[bold14] _____ * //
    titleLarge: TextStyle(
      fontSize: 16.sp,
      fontWeight: FontWeight.w600,
    ),
    titleMedium: TextStyle(
      fontSize: 16.sp,
      fontWeight: FontWeight.w500,
    ),
    titleSmall: TextStyle(
      fontSize: 14.sp,
      fontWeight: FontWeight.bold,
    ),
    // * _____ Body [semi14]-[medium14]-[regular14] _____ * //
    bodyLarge: TextStyle(
      fontSize: 14.sp,
      fontWeight: FontWeight.w600,
    ),
    bodyMedium: TextStyle(
      fontSize: 14.sp,
      fontWeight: FontWeight.w500,
    ),
    bodySmall: TextStyle(
      fontSize: 14.sp,
      fontWeight: FontWeight.w400,
    ),
    // * _____ Label [bold12]-[regular12] _____ * //
    labelLarge: TextStyle(
      fontSize: 12.sp,
      fontWeight: FontWeight.bold,
    ),
    labelMedium: TextStyle(
      fontSize: 12.sp,
      fontWeight: FontWeight.w400,
    ),
  );
}
