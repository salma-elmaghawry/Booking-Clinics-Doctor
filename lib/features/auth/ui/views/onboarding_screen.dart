import 'package:booking_clinics/core/constant/const_color.dart';
import 'package:booking_clinics/core/constant/extension.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../../home/ui/widget/carousel/carousel_indicator.dart';
import '../../data/onboarding_content.dart';
import 'signin.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int currentIndex = 0;
  PageController _controller = PageController(initialPage: 0);

  @override
  void initState() {
    _controller = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          
          Expanded(
            child: PageView.builder(
              controller: _controller,
              itemCount: contents.length,
              onPageChanged: (int index) {
                setState(() {
                  currentIndex = index;
                });
              },
              itemBuilder: (_, i) {
                return Column(
                  children: [
                    
                    SizedBox(
                      height: 65.h,
                      width: double.infinity,
                      child: Image.asset(
                        contents[i].image,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Flexible(
                      child: Text(
                        contents[i].title,
                        style: context.bold18,
                      ),
                    ),
                    SizedBox(height: 1.5.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 6.w),
                      child: Text(
                        contents[i].discription,
                        textAlign: TextAlign.center,
                        style: context.regular14,
                      ),
                    ),
                    SizedBox(height: 2.h),
                  ],
                );
              },
            ),
          ),
          // SizedBox(height: 2.h),
          Container(
            height: 10.w,
            color: Colors.red,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                contents.length,
                (index) => CarouselIndicator(
                  currentIndex == index,
                  color: MediaQuery.of(context).platformBrightness ==
                          Brightness.dark
                      ? currentIndex == index
                          ? Colors.white
                          : Colors.white70
                      : currentIndex == index
                          ? ConstColor.iconDark.color
                          : ConstColor.icon.color,
                ),
              ),
            ),
          ),
          // Evaluated button
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 1.h),
            child: ElevatedButton(
              style: context.theme.elevatedButtonTheme.style?.copyWith(
                minimumSize: WidgetStatePropertyAll(
                  Size(double.infinity, 5.75.h),
                ),
              ),
              child: Text(
                currentIndex == contents.length - 1 ? "Continue" : "Next",
              ),
              onPressed: () {
                if (currentIndex == contents.length - 1) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const SignIn(),
                    ),
                  );
                } else {
                  _controller.nextPage(
                    duration: const Duration(milliseconds: 100),
                    curve: Curves.bounceIn,
                  );
                }
              },
            ),
          ),
          // Skip button (Only show when not on the last page)
          //if (currentIndex != contents.length - 1)
          TextButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => const SignIn(),
                ),
              );
            },
            child: Text(
              "Skip",
              style: context.regular14,
            ),
          ),
          SizedBox(height: 1.5.h), // Adjust for spacing at the bottom
        ],
      ),
    );
  }
}
