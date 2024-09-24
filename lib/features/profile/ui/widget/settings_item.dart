import 'package:booking_clinics_doctor/core/common/dropdown.dart';
import 'package:booking_clinics_doctor/core/constant/extension.dart';
import 'package:flutter/material.dart';

class SettingsItem extends StatefulWidget {
  const SettingsItem({super.key});

  @override
  State<SettingsItem> createState() => _SettingsItemState();
}

class _SettingsItemState extends State<SettingsItem> {
  bool _val = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(
            "Language",
            style: context.regular14,
          ),
          trailing: const DropDown(titles: ["EN", "AR"]),
        ),
        ListTile(
          title: Text(
            "Theme Mode",
            style: context.regular14,
          ),
          subtitle: Text(
            "Experience Hagzy in dark theme",
            style: context.regular14,
          ),
          trailing: Switch(
            value: _val,
            onChanged: (val) {
              setState(() {
                _val = val;
              });
            },
          ),
        ),
      ],
    );
  }
}
