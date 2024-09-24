import 'text_theme.dart';
import 'custom_borders.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:booking_clinics/core/constant/const_color.dart';

ThemeData lightTheme() {
  return ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.light(primary: ConstColor.primary.color),
    scaffoldBackgroundColor: Colors.white,
    // ! _____ AppBar _____ ! //
    appBarTheme: AppBarTheme(
      titleTextStyle: TextStyle(
        fontSize: 18.sp,
        color: Colors.black,
        fontWeight: FontWeight.w500,
      ),
      centerTitle: true,
      titleSpacing: 4.w,
      scrolledUnderElevation: 0,
      backgroundColor: Colors.white,
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
    ),
    // ! _____ TabBar _____ ! //
    tabBarTheme: TabBarTheme(
      dividerHeight: 0.6,
      labelColor: Colors.white,
      dividerColor: Colors.transparent,
      indicatorSize: TabBarIndicatorSize.tab,
      unselectedLabelColor: ConstColor.textBtn.color,
      splashFactory: NoSplash.splashFactory,
      labelStyle: TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
      ),
      unselectedLabelStyle: TextStyle(fontSize: 14.sp),
      labelPadding: EdgeInsets.symmetric(horizontal: 0.5.w),
      indicator: ShapeDecoration(
        color: ConstColor.main.color,
        shape: StadiumBorder(
          side: BorderSide(color: ConstColor.main.color),
        ),
      ),
    ),
    // ! _____ Card Theme _____ ! //
    cardTheme: CardTheme(
      elevation: 4,
      margin: EdgeInsets.zero,
      clipBehavior: Clip.hardEdge,
      color: ConstColor.secondary.color,
    ),
    // ! _____ Text Theme _____ ! //
    textTheme: textTheme(),
    fontFamily: "Inter_Light",
    // ! _____ ListTile _____ ! //
    listTileTheme: ListTileThemeData(
      dense: true,
      textColor: Colors.black54,
      contentPadding: EdgeInsets.zero,
      iconColor: ConstColor.main.color,
      leadingAndTrailingTextStyle: const TextStyle(color: Colors.white),
    ),
    // ! _____ Icon _____ ! //
    iconTheme: IconThemeData(
      size: 20.sp,
      color: ConstColor.dark.color,
    ),
    // ! _____ ElevatedButton _____ ! //
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: ConstColor.secondary.color,
        backgroundColor: ConstColor.dark.color,
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
        backgroundColor: ConstColor.secondary.color,
        foregroundColor: ConstColor.iconDark.color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(3.w),
          side: BorderSide(color: ConstColor.secondary.color),
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
        foregroundColor: ConstColor.textBtn.color,
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
    //     foregroundColor: ConstColor.dark.color,
    //     backgroundColor: ConstColor.secondary.color,
    //   ),
    // ),
    // ! _____ Bottom App Bar _____ ! //
    bottomAppBarTheme: BottomAppBarTheme(
      height: 6.5.h,
      color: Colors.white,
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
      constraints: BoxConstraints(
        maxHeight: 35.h,
        minHeight: 10.h,
        minWidth: double.infinity,
      ),
      backgroundColor: Colors.white,
    ),
    // ! _____ Vertical & Horizontal Divider Theme _____ ! //
    dividerTheme: DividerThemeData(
      space: 2.h,
      color: MyColors.gray,
    ),
    // ! _____ Dialog Theme _____ ! //
    dialogTheme: DialogTheme(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      backgroundColor: ConstColor.secondary.color,
    ),
    // ! _____ Switch Theme _____ ! //
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith(
        (state) {
          if (state.contains(WidgetState.selected)) {
            return ConstColor.dark.color;
          } else {
            return ConstColor.icon.color;
          }
        },
      ),
      trackOutlineColor: WidgetStateProperty.resolveWith(
        (state) {
          return Colors.white;
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
      isDense: true,
      fillColor: ConstColor.secondary.color,
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
