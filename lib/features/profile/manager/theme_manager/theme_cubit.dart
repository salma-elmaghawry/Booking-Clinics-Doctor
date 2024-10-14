import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeCubit extends Cubit<ThemeMode?> {
  ThemeCubit() : super(null);
  static const String _themeKey = 'THEME_MODE';

  // ! Load the theme mode from SharedPreferences
  Future<void> loadTheme() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? themeModeString = prefs.getString(_themeKey);
    themeModeString != null
        ? emit(_themeFromString(themeModeString))
        : emit(ThemeMode.system);
    FlutterNativeSplash.remove();
  }

  // ! Toggle between light and dark mode
  Future<void> toggleTheme(ThemeMode themeMode) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_themeKey, _themeToString(themeMode));
    emit(themeMode);
  }

  // ! Convert ThemeMode to a string for SharedPreferences
  String _themeToString(ThemeMode themeMode) =>
      themeMode.toString().split('.').last;

  // ! Convert string back to ThemeMode
  ThemeMode _themeFromString(String themeString) {
    switch (themeString) {
      case "light":
        return ThemeMode.light;
      case "dark":
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }
}
