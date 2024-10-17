import 'package:booking_clinics_doctor/core/theme/text_theme.dart';

import 'custom_borders.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import '../constant/const_color.dart';

ThemeData darkTheme() {
  return ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.dark(primary: ConstColor.primary.color),
    scaffoldBackgroundColor: ConstColor.dark.color,
    // ! _____ AppBar _____ ! //
    appBarTheme: AppBarTheme(
      titleTextStyle: TextStyle(
        fontSize: 18.sp,
        fontWeight: FontWeight.w500,
        color: ConstColor.secondary.color,
      ),
      titleSpacing: 0,
      centerTitle: true,
      scrolledUnderElevation: 0,
      backgroundColor: ConstColor.dark.color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(4.w),
          bottomRight: Radius.circular(4.w),
        ),
      ),
      iconTheme: IconThemeData(
        size: 20.sp,
        color: ConstColor.icon.color,
      ),
      actionsIconTheme: IconThemeData(
        size: 20.sp,
        color: ConstColor.icon.color,
      ),
    ),
    // ! _____ TabBar _____ ! //
    tabBarTheme: TabBarTheme(
      dividerHeight: 0.6,
      labelColor: Colors.white,
      dividerColor: Colors.transparent,
      indicatorSize: TabBarIndicatorSize.tab,
      unselectedLabelColor: ConstColor.icon.color,
      splashFactory: NoSplash.splashFactory,
      labelStyle: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
      unselectedLabelStyle: TextStyle(fontSize: 14.sp),
      labelPadding: EdgeInsets.symmetric(horizontal: 0.5.w),
      overlayColor: const WidgetStatePropertyAll(Colors.transparent),
      indicator: ShapeDecoration(
        shape: StadiumBorder(
          side: BorderSide(color: ConstColor.primary.color, width: .5.w),
        ),
      ),
    ),
    // ! _____ Card Theme _____ ! //
    cardTheme: CardTheme(
      elevation: 0,
      margin: EdgeInsets.zero,
      clipBehavior: Clip.hardEdge,
      color: ConstColor.iconDark.color,
    ),
    // ! _____ Text Theme _____ ! //
    textTheme: textTheme(),
    fontFamily: "Inter_Light",
    // ! _____ ListTile _____ ! //
    listTileTheme: ListTileThemeData(
      dense: true,
      textColor: Colors.white,
      contentPadding: EdgeInsets.zero,
      iconColor: ConstColor.icon.color,
      titleTextStyle: TextStyle(
        inherit: false,
        fontSize: 15.5.sp,
        fontWeight: FontWeight.w600,
      ),
      subtitleTextStyle: TextStyle(
        inherit: false,
        fontSize: 14.sp,
      ),
      leadingAndTrailingTextStyle: const TextStyle(color: Colors.white),
    ),
    // ! _____ Icon _____ ! //
    iconTheme: IconThemeData(
      size: 20.sp,
      color: ConstColor.icon.color,
    ),
    // ! _____ ElevatedButton _____ ! //
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: ConstColor.dark.color,
        backgroundColor: ConstColor.primary.color,
        // shape: RoundedRectangleBorder(
        //   borderRadius: BorderRadius.circular(3.25.w),
        // ),
        textStyle: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
    // ! _____ OutlinedButton _____ ! //
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        // backgroundColor: ConstColor.iconDark.color,
        foregroundColor: ConstColor.secondary.color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
          side: BorderSide(color: ConstColor.primary.color),
        ),
        textStyle: TextStyle(
          inherit: false,
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
    // ! _____ TextButton _____ ! //
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: ConstColor.primary.color,
        textStyle: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
    // ! _____ Icon Button _____ ! //
    // iconButtonTheme: IconButtonThemeData(
    //   style: IconButton.styleFrom(
    //     iconSize: 20.sp,
    //     backgroundColor: Colors.white10,
    //     foregroundColor: ConstColor.secondary.color,
    //   ),
    // ),
    // ! _____ Bottom App Bar _____ ! //
    bottomAppBarTheme: BottomAppBarTheme(
      height: 6.5.h,
      color: ConstColor.dark.color,
      shape: const CircularNotchedRectangle(),
      padding: EdgeInsets.symmetric(horizontal: 4.w),
    ),
    // ! _____ Floating Button _____ ! //
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      elevation: 0,
      highlightElevation: 0,
      shape: CircleBorder(),
      backgroundColor: Colors.white70,
      foregroundColor: Colors.black87,
    ),
    // ! _____ Fixed Bottom Sheet _____ ! //
    bottomSheetTheme: BottomSheetThemeData(
      showDragHandle: true,
      constraints: const BoxConstraints(
        minWidth: double.infinity,
      ),
      dragHandleColor: ConstColor.primary.color,
      backgroundColor: ConstColor.dark.color,
    ),
    // ! _____ Vertical & Horizontal Divider Theme _____ ! //
    dividerTheme: DividerThemeData(
      space: 2.h,
      color: ConstColor.textBtn.color,
    ),
    // ! _____ Dialog Theme _____ ! //
    dialogTheme: DialogTheme(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(4.w),
          topRight: Radius.circular(4.w),
        ),
      ),
      backgroundColor: ConstColor.iconDark.color,
    ),
    // ! _____ Switch Theme _____ ! //
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith(
        (state) {
          if (state.contains(WidgetState.selected)) {
            return ConstColor.iconDark.color;
          } else {
            return ConstColor.textBtn.color;
          }
        },
      ),
      trackOutlineColor: WidgetStateProperty.resolveWith(
        (state) {
          return ConstColor.dark.color;
        },
      ),
      trackColor: WidgetStateProperty.resolveWith(
        (state) {
          if (state.contains(WidgetState.selected)) {
            return ConstColor.primary.color;
          } else {
            return ConstColor.secondary.color;
          }
        },
      ),
    ),
    // ! _____ Input Theme _____ ! //
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      // isDense: true,
      fillColor: ConstColor.iconDark.color,
      hintStyle: TextStyle(
        fontSize: 14.5.sp,
        fontWeight: FontWeight.w400,
        color: ConstColor.icon.color,
      ),
      labelStyle: TextStyle(
        fontSize: 14.5.sp,
        fontWeight: FontWeight.w400,
        color: ConstColor.icon.color,
      ),
      floatingLabelStyle: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w600,
        color: ConstColor.primary.color,
      ),
      iconColor: ConstColor.icon.color,
      prefixIconColor: ConstColor.icon.color,
      border: buildBorder(),
      enabledBorder: buildBorder(),
      disabledBorder: buildBorder(),
      focusedErrorBorder: buildBorder(),
      focusedBorder: buildFocusedBorder(),
    ),
  );
}
