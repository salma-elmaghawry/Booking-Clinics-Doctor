import 'package:booking_clinics/core/constant/extension.dart';
import 'package:flutter/material.dart';
import '../constant/const_color.dart';

class SectionHeading extends StatelessWidget {
  const SectionHeading({
    super.key,
    this.textColor = MyColors.dark,
    required this.title,
    this.buttonTitle = "See All",
    this.showActionButton = true,
    this.onPressed,
  });

  final Color? textColor;
  final bool showActionButton;
  final String title, buttonTitle;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: context.bold18,
        ),
        if (showActionButton)
          TextButton(
            onPressed: onPressed ?? () {},
            child: Text(
              buttonTitle,
              style: context.regular14,
            ),
          ),
      ],
    );
  }
}
