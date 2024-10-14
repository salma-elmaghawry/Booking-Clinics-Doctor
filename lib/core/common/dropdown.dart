import 'package:sizer/sizer.dart';
import '../constant/const_color.dart';
import 'package:flutter/material.dart';
import 'package:booking_clinics_doctor/core/constant/extension.dart';

class DropDown extends StatefulWidget {
  final int? value;
  final bool? isDense;
  final Widget? underline;
  final bool? isExpanded;
  final double? menuWidth;
  final List<String> titles;

  final void Function(int? val)? onSelect;
  const DropDown({
    super.key,
    this.onSelect,
    this.value = 0,
    this.menuWidth,
    this.isDense,
    this.underline,
    this.isExpanded = false,
    required this.titles,
  });

  @override
  State<DropDown> createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> {
  @override
  Widget build(BuildContext context) {
    return DropdownButton<int>(
      value: widget.value,
      isExpanded: widget.isExpanded ?? false,
      isDense: widget.isDense ?? true,
      iconEnabledColor: ConstColor.primary.color,
      dropdownColor: Theme.of(context).brightness == Brightness.dark
          ? ConstColor.iconDark.color
          : null,
      menuWidth: widget.menuWidth ?? 50.w,
      padding: EdgeInsets.only(
        left: 4.w,
        top: 0.5.h,
        right: 2.w,
        bottom: 0.5.w,
      ),
      style: context.regular14,
      borderRadius: BorderRadius.circular(3.5.w),
      underline: widget.underline ?? const SizedBox.shrink(),
      items: List.generate(
        widget.titles.length,
        (index) => DropdownMenuItem(
          value: index,
          child: Text(widget.titles[index]),
        ),
      ),
      onChanged: (val) {
        if (widget.onSelect != null) widget.onSelect!(val);
      },
    );
  }
}
