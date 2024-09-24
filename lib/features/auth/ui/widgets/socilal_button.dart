import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SocialButton extends StatelessWidget {
  final String title;
  final String iconUrl;

  const SocialButton({required this.iconUrl, required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {},
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(iconUrl),
          const SizedBox(width: 8),
          Text(title),
        ],
      ),
    );
  }
}
