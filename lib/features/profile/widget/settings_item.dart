import 'package:booking_clinics_doctor/core/constant/extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constant/const_color.dart';
import '../../../core/common/dropdown.dart';
import '../manager/theme_manager/theme_cubit.dart';

class SettingsItem extends StatefulWidget {
  const SettingsItem({super.key});

  @override
  State<SettingsItem> createState() => _SettingsItemState();
}

class _SettingsItemState extends State<SettingsItem> {
  late int _value;

  // ! Map ThemeMode to the index in the dropdown (0: Light, 1: Dark, 2: System)
  int _themeModeToIndex(ThemeMode? themeMode) {
    switch (themeMode) {
      case ThemeMode.light:
        return 0;
      case ThemeMode.dark:
        return 1;
      case ThemeMode.system:
      default:
        return 2;
    }
  }

  // ! Map dropdown index to ThemeMode
  ThemeMode _indexToThemeMode(int index) {
    switch (index) {
      case 0:
        return ThemeMode.light;
      case 1:
        return ThemeMode.dark;
      case 2:
      default:
        return ThemeMode.system;
    }
  }

  @override
  void initState() {
    super.initState();
    // ! Initialize selectedValue based on current theme
    final themeMode = context.read<ThemeCubit>().state;
    _value = _themeModeToIndex(themeMode);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // ListTile(
        //   title: Text(
        //     "Language",
        //     style: context.regular14,
        //   ),
        //   trailing: const DropDown(titles: ["EN", "AR"]),
        // ),

        ListTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Theme Mode", style: context.semi14),
              DropDown(
                value: _value,
                onSelect: (val) {
                  if (val != null) {
                    // ! Update the theme using the ThemeCubit
                    final themeMode = _indexToThemeMode(val);
                    context.read<ThemeCubit>().toggleTheme(themeMode);
                    setState(() {
                      _value = val;
                    });
                  }
                },
                titles: const ["Light Mode", "Dark Mode", "System Default"],
              ),
            ],
          ),
          subtitle: Text(
            "Experience Hagzy in dark theme",
            style: context.regular14?.copyWith(color: ConstColor.icon.color),
          ),
        ),
      ],
    );
  }
}
