import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';

class MapsMenu extends StatelessWidget {
  const MapsMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      child: IconButton(
        onPressed: () {},
        icon: Icon(Icons.menu_rounded, size: 20.sp),
      ),
    );
  }
}
