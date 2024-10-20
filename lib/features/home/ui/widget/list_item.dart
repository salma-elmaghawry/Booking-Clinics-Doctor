import 'package:cached_network_image/cached_network_image.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import '../../../../core/common/rate.dart';
import 'package:booking_clinics_doctor/core/constant/extension.dart';
import 'package:booking_clinics_doctor/data/models/doctor_model.dart';
import 'package:booking_clinics_doctor/core/constant/const_color.dart';

class ListItem extends StatelessWidget {
  final DoctorModel doctor;
  final void Function()? computeRoute;
  const ListItem({this.computeRoute, required this.doctor, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        CachedNetworkImage(
          imageUrl: doctor.imageUrl ?? "",
          errorListener: (value) {},
          errorWidget: (context, url, error) => Icon(
            Iconsax.danger,
            size: 42.sp,
          ),
          fit: BoxFit.cover,
          height: 20.h,
        ),
        const Spacer(),
        ListTile(
          dense: true,
          contentPadding: EdgeInsets.symmetric(horizontal: 4.w),
          title: Row(
            children: [
              Flexible(
                child: Text(
                  "${doctor.name},",
                  overflow: TextOverflow.ellipsis,
                  style: context.semi16,
                ),
              ),
              SizedBox(width: 2.w),
              Text(
                doctor.speciality,
                overflow: TextOverflow.ellipsis,
                style: context.medium14?.copyWith(
                  color: ConstColor.icon.color,
                ),
              ),
            ],
          ),
          subtitle: Row(
            children: [
              Flexible(
                child: Text(
                  doctor.address ?? "",
                  overflow: TextOverflow.ellipsis,
                  style: context.medium14?.copyWith(
                    color: ConstColor.icon.color,
                  ),
                ),
              ),
              SizedBox(width: 2.w),
              if (computeRoute != null) const Rate()
            ],
          ),
          trailing: computeRoute != null
              ? IconButton(
                  onPressed: computeRoute,
                  icon: const Icon(Icons.directions),
                )
              : const Rate(),
        ),
        const Spacer(),
      ],
    );
  }
}
