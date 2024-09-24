import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';

void showSnackBar(
  BuildContext context, {
  required String title,
  required IconData icon,
  required Color color,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(5.w),
          topRight: Radius.circular(5.w),
        ),
      ),
      content: Row(
        children: [
          Icon(icon, color:color),
          SizedBox(width: 2.w),
          Flexible(
            child: Text(
              title,
              style: const TextStyle(
                letterSpacing: 0.3,
                fontFamily: 'Pacifico',
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
