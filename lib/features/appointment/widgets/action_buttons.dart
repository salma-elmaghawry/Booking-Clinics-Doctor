import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sizer/sizer.dart';
import '../../../core/common/custom_button.dart';
import '../../../core/constant/const_color.dart';
import '../../../core/helper/show_msg.dart';
import '../../../data/models/booking.dart';
import '../manager/appointment_cubit.dart';
import 'review_bottom_sheet.dart';

class ActionButtons extends StatelessWidget {
  final String status;
  final int bookingId;
  final List<Booking> bookings;
  const ActionButtons({
    super.key,
    required this.status,
    required this.bookings,
    required this.bookingId,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    if (status == 'Pending') {
      return Row(
        children: bookings[bookingId].isAccepted == 1
            ? []
            : [
                Expanded(
                  child: CustomButton(
                    text: 'Deny',
                    color: MyColors.gray,
                    textSize: 14.5.sp,
                    padding: const EdgeInsets.all(12),
                    textColor: MyColors.dark2,
                    onTap: () {
                      final read = context.read<AppointmentCubit>();
                      showMsg(
                        context,
                        title: "Cancel",
                        msg:
                            "Are you sure? This appointment for ${bookings[bookingId].name} will be Rejected!",
                        alertWidget: Icon(
                          Iconsax.danger,
                          size: 35.sp,
                          color: MediaQuery.of(context).platformBrightness ==
                                  Brightness.light
                              ? Colors.black
                              : ConstColor.primary.color,
                        ),
                        onPressed: () async {
                          context
                              .read<AppointmentCubit>()
                              .rejectBooking(index: read.index!);
                        },
                      );
                      context.read<AppointmentCubit>().index = bookingId;
                    },
                  ),
                ),
                SizedBox(width: 4.w),
                Expanded(
                  child: CustomButton(
                    text: 'Accept',
                    color: isDark ? MyColors.primary : MyColors.dark,
                    textSize: 14.5.sp,
                    padding: const EdgeInsets.all(12),
                    textColor: isDark ? MyColors.dark : Colors.white,
                    onTap: () {
                      final read = context.read<AppointmentCubit>();
                      showMsg(
                        context,
                        title: "Accept",
                        msg:
                            "Are you sure? Accept appointment for ${bookings[bookingId].name}",
                        alertWidget: Icon(
                          Iconsax.danger,
                          size: 35.sp,
                          color: MediaQuery.of(context).platformBrightness ==
                                  Brightness.light
                              ? Colors.black
                              : ConstColor.primary.color,
                        ),
                        onPressed: () async {
                          context
                              .read<AppointmentCubit>()
                              .agreeBooking(index: read.index!);
                        },
                      );
                      context.read<AppointmentCubit>().index = bookingId;
                    },
                  ),
                ),
              ],
      );
    } else if (status == 'Completed') {
      return Row(
        children: [
          Expanded(
            child: CustomButton(
              text: 'Re-Book',
              color: MyColors.gray,
              textSize: 14.5.sp,
              padding: const EdgeInsets.all(12),
              textColor: MyColors.dark2,
              onTap: () {},
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: CustomButton(
              text: 'Add Review',
              color: isDark ? MyColors.primary : MyColors.dark,
              textSize: 14.5.sp,
              padding: const EdgeInsets.all(12),
              textColor: isDark ? MyColors.dark : Colors.white,
              onTap: () => postReview(context),
            ),
          ),
        ],
      );
    } else if (status == 'Canceled') {
      return CustomButton(
        text: 'Re-Book',
        color: isDark ? MyColors.primary : MyColors.dark,
        textSize: 14.5.sp,
        padding: const EdgeInsets.all(15),
        textColor: isDark ? MyColors.dark : Colors.white,
        onTap: () {},
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  Future<Widget?> postReview(BuildContext context) {
    return showModalBottomSheet<Widget>(
      context: context,
      isScrollControlled: true,
      builder: (_) => BlocProvider<AppointmentCubit>.value(
        value: context.read<AppointmentCubit>(),
        child: ReviewSheet(booking: bookings[bookingId]),
      ),
    );
  }
}
