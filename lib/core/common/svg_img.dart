import '../constant/const_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SvgImage extends StatelessWidget {
  final String image;
  const SvgImage({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      image,
      colorFilter: ColorFilter.mode(
        MediaQuery.of(context).platformBrightness == Brightness.light
            ? ConstColor.icon.color
            : ConstColor.secondary.color,
        BlendMode.srcIn,
      ),
    );
  }
}
