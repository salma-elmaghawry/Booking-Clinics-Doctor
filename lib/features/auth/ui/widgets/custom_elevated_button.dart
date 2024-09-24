import 'package:booking_clinics/core/constant/extension.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({required this.title, this.onPressed, super.key});
  final String title;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: context.theme.elevatedButtonTheme.style?.copyWith(
        minimumSize: WidgetStatePropertyAll(
          Size(double.infinity, 5.75.h),
        ),
      ),
      onPressed: onPressed ?? () {},
      child: Text(title),
    );
  }
}
