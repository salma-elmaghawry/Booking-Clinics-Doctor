import 'package:booking_clinics_doctor/core/constant/extension.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../constant/const_color.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.text,
    this.color,
    this.onTap,
    this.padding = const EdgeInsets.symmetric(vertical: 12),
    this.textColor,
    this.textSize = 16,
    this.height,
    this.borderRadius = 15,
  });

  final String text;
  final Color? textColor, color;
  final double? textSize, height, borderRadius;
  final void Function()? onTap;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    final isDark = context.theme.brightness == Brightness.dark;
    return Material(
      color:
          color ?? (isDark ? ConstColor.primary.color : ConstColor.dark.color),
      borderRadius: BorderRadius.circular(borderRadius!),
      child: InkWell(
        onTap: onTap ?? () {},
        borderRadius: BorderRadius.circular(borderRadius!),
        child: Container(
          width: double.infinity,
          height: height,
          padding: padding,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius!),
          ),
          child: Center(
            child: Text(
              text,
              style: context.bold12?.copyWith(
                fontSize: textSize ?? 14.sp,
                fontWeight: FontWeight.w600,
                color: textColor ??
                    (isDark
                        ? ConstColor.dark.color
                        : ConstColor.secondary.color),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
