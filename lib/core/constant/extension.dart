import 'package:flutter/material.dart';

extension BuildContextExtensions on BuildContext {
  // ! _____ Text Extensions _____ ! //
  TextTheme get textTheme => theme.textTheme;
  // * _____ Headline [semi20]-[bold18]-[bold16]
  TextStyle? get semi20 => theme.textTheme.headlineLarge;
  TextStyle? get bold18 => theme.textTheme.headlineMedium;
  TextStyle? get bold16 => theme.textTheme.headlineSmall;
  // * _____
  // * _____ Title [semi16]-[medium16]-[bold14]
  TextStyle? get semi16 => theme.textTheme.titleLarge;
  TextStyle? get medium16 => theme.textTheme.titleMedium;
  TextStyle? get bold14 => theme.textTheme.titleSmall;
  // * _____
  // * _____ Body [semi14]-[medium14]-[regular14]
  TextStyle? get semi14 => theme.textTheme.bodyLarge;
  TextStyle? get medium14 => theme.textTheme.bodyMedium;
  TextStyle? get regular14 => theme.textTheme.bodySmall;
  // * _____
  // * _____ Label [bold12]-[regular12]
  TextStyle? get bold12 => theme.textTheme.labelLarge;
  TextStyle? get regular12 => theme.textTheme.labelMedium;
  // * _____
  // ! _____
  ThemeData get theme => Theme.of(this);
  ScaffoldState get scaffold => Scaffold.of(this);
  ColorScheme get colorScheme => theme.colorScheme;
  NavigatorState get nav => Navigator.of(this);
  FocusScopeNode get focusScope => FocusScope.of(this);
  MediaQueryData get mediaQuery => MediaQuery.of(this);
  DefaultTextStyle get defaultTextStyle => DefaultTextStyle.of(this);
  ScaffoldMessengerState get scaffoldMessenger => ScaffoldMessenger.of(this);
}
