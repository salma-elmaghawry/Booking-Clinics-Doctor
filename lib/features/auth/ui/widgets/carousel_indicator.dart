import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';

class CarouselIndicator extends StatelessWidget {
  final Color? color;
  final bool _currentSlide;
  const CarouselIndicator(this._currentSlide, {this.color, super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      height: 2.25.w,
      width: _currentSlide ? 7.w : 2.25.w,
      margin: EdgeInsets.only(right: 2.w, bottom: 1.h),
      decoration: BoxDecoration(
        color: color == null
            ? _currentSlide
                ? Colors.white
                : Colors.white54
            : null,
        borderRadius: BorderRadius.circular(50),
      ),
      curve: Curves.easeInOut,
      duration: const Duration(milliseconds: 250),
    );
  }
}
