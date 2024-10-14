import 'package:booking_clinics_doctor/core/constant/const_string.dart';
import 'package:booking_clinics_doctor/data/models/doctor_model.dart';
import 'package:sizer/sizer.dart';
import 'package:iconsax/iconsax.dart';
import 'package:flutter/material.dart';
import 'package:booking_clinics_doctor/core/constant/extension.dart';
import '../../../../core/common/custom_network_img.dart';
import '../../../../core/constant/images_path.dart';

class SeeAllTab extends StatelessWidget {
  final List<DoctorModel> doctors;
  const SeeAllTab(this.doctors, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: doctors.length,
      padding: EdgeInsets.only(top: 1.h, left: 4.w, right: 4.w, bottom: 2.h),
      itemBuilder: (_, index) {
        return InkWell(
          onTap: () async {
            context.nav.pushNamed(
              Routes.doctorDetailsRoute,
              arguments: {
                'doctorId': doctors[index].id,
                'doctorName': doctors[index].name,
              },
            );
          },
          child: Card(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 2.w, horizontal: 2.w),
              child: Row(
                children: [
                  CustomNetworkImage(
                    imageUrl: doctors[index].imageUrl,
                    fallbackAsset: MyImages.doctorAvatar,
                    width: 35.w,
                    height: 35.w,
                    borderRadius: 3.w,
                    fit: BoxFit.cover,
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 2.w),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(doctors[index].name, style: context.bold16),
                              SizedBox(width: 1.w),
                            ],
                          ),
                          const Divider(),
                          Text(doctors[index].speciality,
                              style: context.semi14),
                          SizedBox(height: 1.h),
                          Row(
                            children: [
                              const Icon(Iconsax.location4, size: 17),
                              SizedBox(width: 1.w),
                              Flexible(
                                child: Text(
                                  doctors[index].address ?? "Unknown",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: context.regular14,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 0.5.h),
                          IntrinsicHeight(
                            child: Row(
                              children: [
                                const Icon(Iconsax.star1,
                                    color: Colors.orangeAccent),
                                SizedBox(width: 1.w),
                                Text(
                                  "${doctors[index].rating}",
                                  style: context.regular14,
                                ),
                                const VerticalDivider(),
                                Text(
                                  "${doctors[index].reviews.length} Reviews",
                                  style: context.regular14,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
      separatorBuilder: (_, index) => SizedBox(height: 1.5.h),
    );
  }
}
