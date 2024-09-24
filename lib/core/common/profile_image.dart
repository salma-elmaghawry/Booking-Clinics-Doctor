import 'package:sizer/sizer.dart';
import '../constant/const_color.dart';
import 'package:iconsax/iconsax.dart';
import 'package:flutter/material.dart';

class ProfileImage extends StatelessWidget {
  final ImageProvider? image;
  final Future<void> Function()? onTap;
  const ProfileImage({this.onTap, this.image, super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      highlightColor: Colors.transparent,
      splashFactory: NoSplash.splashFactory,
      borderRadius: BorderRadius.circular(15.w),
      child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.hardEdge,
        children: [
          CircleAvatar(
            radius: 20.w,
            backgroundImage: image,
            backgroundColor: ConstColor.iconDark.color,
            child: image == null
                ? Icon(Iconsax.user, size: 20.w, color: Colors.white)
                : null,
          ),
          Positioned(
            right: 0,
            bottom: 7.w,
            child: Container(
              padding: EdgeInsets.all(1.2.w),
              decoration: BoxDecoration(
                color: ConstColor.main.color,
                borderRadius: BorderRadius.circular(3.w),
              ),
              child: const Icon(Icons.edit, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
