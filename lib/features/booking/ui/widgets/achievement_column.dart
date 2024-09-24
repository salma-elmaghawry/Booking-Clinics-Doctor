import 'package:booking_clinics_doctor/core/constant/extension.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/constant/const_color.dart';

class AchievementRow extends StatelessWidget {
  const AchievementRow({
    super.key,
    required this.patients,
    required this.experience,
    required this.rating,
    required this.reviews,
  });

  final int reviews, patients, experience;
  final double rating;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        AchievementItem(
          text: 'patients',
          icon: Iconsax.profile_2user5,
          number: patients.toString(),
        ),
        AchievementItem(
          text: 'experience',
          icon: Iconsax.cup5,
          number: experience.toString(),
        ),
        AchievementItem(
          text: 'rating',
          icon: Iconsax.star5,
          number: rating.toString(),
        ),
        AchievementItem(
          text: 'reviews',
          icon: Iconsax.messages_15,
          number: reviews.toString(),
        ),
      ],
    );
  }
}

class AchievementItem extends StatelessWidget {
  const AchievementItem({
    super.key,
    this.icon = Icons.people,
    this.number = '2000',
    this.text = 'patients',
  });

  final IconData icon;
  final String number;
  final String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 12.h,
      child: Column(
        children: [
          Container(
            height: 7.h,
            width: 7.h,
            decoration: const BoxDecoration(
              color: MyColors.lightGray,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: MyColors.dark, size: 4.h),
          ),
          Text(number, style: context.semi14),
          Text(text, style: context.regular14),
        ],
      ),
    );
  }
}
