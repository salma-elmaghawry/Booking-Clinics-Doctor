import 'package:booking_clinics_doctor/core/constant/const_color.dart';
import 'package:booking_clinics_doctor/core/constant/extension.dart';
import 'package:booking_clinics_doctor/features/home/ui/manager/all_doctors/all_doctors_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constant/const_string.dart';
import 'list_item.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';

class CarouselSlider extends StatelessWidget {
  final List<String> images;
  const CarouselSlider({required this.images, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 32.h,
      child: BlocBuilder<AllDoctorsCubit, AllDoctorsState>(
        builder: (_, state) {
          if (state is AllDoctorsSuccess) {
            return CarouselView(
              onTap: (index) {
                context.nav.pushNamed(
                  Routes.doctorDetailsRoute,
                  arguments: {
                    "doctorId": state.doctors[index].id,
                    "patientName": state.doctors[index].name,
                  },
                );
              },
              elevation: 2,
              shrinkExtent: 95.w,
              itemSnapping: true,
              itemExtent: double.infinity,
              backgroundColor:
                  MediaQuery.of(context).platformBrightness == Brightness.light
                      ? Colors.white
                      : ConstColor.iconDark.color,
              padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 4.w),
              children: List.generate(
                images.length,
                (index) => ListItem(
                  doctor: state.doctors[index],
                  computeRoute: () {
                    return ;
                  },
                ),
              ),
            );
          } else if (state is AllDoctorsFailure) {
            return Center(
              child: Text(state.error),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(
                color: ConstColor.primary.color,
              ),
            );
          }
        },
      ),
    );
  }
}
