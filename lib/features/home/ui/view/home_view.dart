import 'package:booking_clinics_doctor/core/common/see_all.dart';
import 'package:booking_clinics_doctor/features/profile/ui/profile_manager/profile_cubit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import '../../../../core/common/input.dart';
import 'package:booking_clinics_doctor/core/constant/extension.dart';
import '../../../../core/constant/const_color.dart';
import '../../../appointment/manager/appointment_cubit.dart';
import '../widget/custom_bar_chart.dart';
import '../widget/today_booking.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.only(
        left: 6.w,
        right: 6.w,
        bottom: 2.h,
        top: MediaQuery.of(context).padding.top + 2.h,
      ),
      children: [
        ListTile(
          title: BlocBuilder<ProfileCubit, ProfileState>(
            builder: (_, state) {
              if (state is ProfileSuccess) {
                return Text("Hi, ${state.model.name}", style: context.semi16);
              }
              return const SizedBox.shrink();
            },
          ),
          subtitle: Text(
            "Have a nice day at work",
            style: context.bold18?.copyWith(
              color: ConstColor.icon.color,
            ),
          ),
          trailing: BlocBuilder<ProfileCubit, ProfileState>(
            builder: (_, state) {
              if (state is ProfileSuccess && state.model.imageUrl != null) {
                return CircleAvatar(
                  radius: 8.w,
                  backgroundImage: CachedNetworkImageProvider(
                    state.model.imageUrl!,
                  ),
                );
              } else {
                return CircleAvatar(
                  radius: 8.w,
                  backgroundColor: ConstColor.textBtn.color,
                  child: const Icon(Iconsax.user, color: Colors.white),
                );
              }
            },
          ),
        ),
        SizedBox(height: 2.h),
        const Input(
          isDense: false,
          prefix: Iconsax.search_normal,
          hint: "Search Appointment",
        ),
        SizedBox(height: 4.h),
        Padding(
          padding: EdgeInsets.only(
            left: 2.w,
            right: 2.w,
            bottom: 4.h,
          ),
          child: GestureDetector(
            onLongPress: () {},
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Iconsax.info_circle,
                  color:
                      context.mediaQuery.platformBrightness == Brightness.dark
                          ? ConstColor.primary.color
                          : ConstColor.icon.color,
                ),
                SizedBox(width: 4.w),
                Text(
                  "More Info",
                  style: context.regular14?.copyWith(
                    color: ConstColor.icon.color,
                  ),
                ),
              ],
            ),
          ),
        ),
        CustomBarChart(
          weeklyData: context.read<AppointmentCubit>().weeklyData,
        ),
        SizedBox(height: 4.h),
        const ListHeader(title: "Today's Booking"),
        const TodayBooking(),
      ],
    );
  }
}
