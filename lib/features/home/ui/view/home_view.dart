import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/common/input.dart';
import '../../../../core/common/see_all.dart';
import '../widget/carousel/carousel_slider.dart';
import '../widget/custom_carousel.dart';
import '../widget/categories.dart';
import '../widget/custom_search.dart';
import '../widget/home_appbar.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  static const List<String> _images = [
    "assets/images/banner_1.jpg",
    "assets/images/banner_5.png",
    "assets/images/banner_4.png",
    "assets/images/banner_2.png",
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            snap: true,
            floating: true,
            toolbarHeight: 14.h,
            automaticallyImplyLeading: false,
            flexibleSpace: const UpperAppBar(),
            bottom: PreferredSize(
              preferredSize: Size(double.infinity, 2.5.h),
              child: Padding(
                padding: EdgeInsets.only(left: 4.w, right: 4.w, bottom: 1.25.h),
                child: Input(
                  onTap: () {
                    showSearch(
                      context: context,
                      delegate: CustomSearch(),
                    );
                  },
                  readOnly: true,
                  hint: "What're you looking for?",
                  prefix: Iconsax.search_normal,
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                const CustomPageView(images: _images),
                const ListHeader(title: "Categories"),
                const Categories(),
                const ListHeader(title: "Nearby Medical Centers"),
                const CarouselSlider(
                  images: [
                    "assets/images/center_1.jpg",
                    "assets/images/center_2.jpg",
                    "assets/images/center_3.jpg",
                  ],
                ),
                SizedBox(height: 8.h),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
