import 'dart:async';
import 'carousel_item.dart';
import 'carousel_indicator.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';

class CustomPageView extends StatefulWidget {
  final List<String> images;
  const CustomPageView({required this.images, super.key});

  @override
  State<CustomPageView> createState() => _CustomPageViewState();
}

class _CustomPageViewState extends State<CustomPageView> {
  Timer? _timer;
  int _index = 0;
  late final PageController _controller;

  @override
  void initState() {
    _controller = PageController(initialPage: 0);
    _autoPlay();
    super.initState();
  }

  void _autoPlay() {
    _timer = Timer.periodic(const Duration(milliseconds: 3500), (Timer _) {
      _index++;
      _controller.animateToPage(
        _index,
        curve: Curves.easeInOut,
        duration: const Duration(milliseconds: 350),
      );
    });
  }

  void _stopPlay() => _timer?.cancel();

  @override
  void dispose() {
    _stopPlay();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // ! Stop the timer when the user starts interacting.
      onPanDown: (_) => _stopPlay(),
      // ! Restart the timer when the user releases their finger.
      onPanEnd: (_) => _autoPlay(),
      // ! Restart the timer if the pan gesture is canceled.
      onPanCancel: () => _autoPlay(),
      child: SizedBox(
        height: 24.h,
        width: double.infinity,
        child: Stack(
          children: [
            PageView.builder(
              controller: _controller,
              onPageChanged: (val) => setState(() => _index = val),
              itemBuilder: (_, index) => CarouselItem(
                image: widget.images[index % widget.images.length],
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 1.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List<CarouselIndicator>.generate(
                  widget.images.length,
                  (index) {
// debugPrint('''
// for index: $index
// is $_index % ${widget.images.length} = ${index % widget.images.length} ? ${_index == index % widget.images.length}
// my condition for carousel indicator is $index == ${_index % widget.images.length} ? ${_index == index % widget.images.length}
// ---------------
// ''');
                    return CarouselIndicator(
                      index == _index % widget.images.length,
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
