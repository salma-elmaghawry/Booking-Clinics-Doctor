import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';

class Input extends StatelessWidget {
  const Input({
    this.label,
    this.suffix,
    this.prefix,
    this.enabled,
    this.readOnly,
    this.isDense,
    this.onSaved,
    this.fillColor,
    this.validator,
    this.onTap,
    this.onChanged,
    this.controller,
    this.keyboardType,
    this.hint,
    this.obscureText = false,
    super.key,
  });

  final bool? readOnly;
  final bool? enabled;
  final bool? isDense;
  final String? label;
  final String? hint;
  final Widget? suffix;
  final IconData? prefix;
  final Color? fillColor;
  final bool? obscureText;
  final TextInputType? keyboardType;
  final void Function()? onTap;
  final void Function(String?)? onSaved;
  final void Function(String?)? onChanged;
  final TextEditingController? controller;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: onTap,
      readOnly: readOnly ?? false,
      onSaved: onSaved,
      onChanged: onChanged,
      controller: controller,
      style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w400),
      onTapOutside: (val) => FocusManager.instance.primaryFocus!.unfocus(),
      validator: validator,
      keyboardType: keyboardType,
      obscureText: obscureText ?? false,
      enabled: enabled,
      decoration: InputDecoration(
        hintText: hint,
        label: label != null ? Text(label!) : null,
        isDense: label != null ? false : true,
        prefixIconConstraints: BoxConstraints(maxWidth: 20.w),
        prefixIcon: prefix != null
            ? Padding(
                padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.5.h),
                child: Icon(prefix, size: 21.sp),
              )
            : null,
      ),
    );
  }
}
