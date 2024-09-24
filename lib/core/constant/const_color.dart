import 'dart:ui';

enum ConstColor {
  main(Color(0xff4B5563)),
  primary(Color(0xffA4CFC3)),
  icon(Color(0xff9CA3AF)),
  textBtn(Color(0xff6B7280)),

  blue(Color(0xff0c8ce9)),
  iconDark(Color(0xff262A34)),
  dark(Color(0xff1C1C1C)),
  secondary(Color(0xffF3F4F6));

  final Color color;
  const ConstColor(this.color);
}

class MyColors {
  static const Color blue = Color(0xff1C64F2);
  static const Color lightGray = Color(0xffF3F4F6);
  static const Color softGray = Color(0xff6B7280);
  static const Color dark = Color(0xff1C2A3A);
  static const Color dark2 = Color(0xff1F2A37);
  static const Color gold = Color(0xffFEB052);
  static const Color primary = Color(0xffA4CFC3);
  static const Color gray = Color(0xffE5E7EB);
}
