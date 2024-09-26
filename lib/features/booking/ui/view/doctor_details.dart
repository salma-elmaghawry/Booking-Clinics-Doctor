import 'package:booking_clinics_doctor/core/constant/extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/common/section_heading.dart';
import '../../../../core/constant/const_color.dart';
import '../../cubit/doc_details_cubit.dart';
import '../widgets/achievement_column.dart';
import '../widgets/reviews_item.dart';
import '../widgets/rounded_doctor_card.dart';

class DoctorDetailsView extends StatelessWidget {
  final String doctorId;

  const DoctorDetailsView({super.key, required this.doctorId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Doctor Details'),
        leading: BackButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.transparent),
        ),
      ),
      body: BlocBuilder<DoctorCubit, DoctorState>(
        builder: (_, state) {
          if (state is DoctorLoading) {
            return Center(
              child: CircularProgressIndicator(color: ConstColor.primary.color),
            );
          } else if (state is DoctorError) {
            return Center(child: Text(state.error));
          } else if (state is DoctorLoaded && state.doctors.isNotEmpty) {
            final doctor = state.doctors.first;
            return ListView(
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
              children: [
                // Doctor Card
                RoundedDoctorCard(doctor: doctor),
                SizedBox(height: 2.h),
                // Achievements Row
                AchievementRow(
                  patients: doctor.patientsNumber ?? 0,
                  experience: doctor.experience ?? 0,
                  rating: doctor.rating ?? 0.0,
                  reviews: doctor.reviews.length,
                ),
                SizedBox(height: 2.h),
                // About me
                const SectionHeading(title: 'About me', showActionButton: false),
                SizedBox(height: 1.h),
                Text(
                  doctor.about ?? "No information provided.",
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: context.regular14,
                ),
                SizedBox(height: 2.h),

                // Working Time
                const SectionHeading(title: 'Working Time', showActionButton: false),
                SizedBox(height: 1.h),
                Text(
                  doctor.workingHours ?? "Not available",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: context.regular14,
                ),
                SizedBox(height: 2.h),

                // Reviews
                const SectionHeading(title: 'Reviews', showActionButton: false),
                SizedBox(height: 0.5.h),
                ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: doctor.reviews.length,
                  itemBuilder: (context, index) => ReviewsItem(
                    image: doctor.reviews[index].imageUrl,
                    name: doctor.reviews[index].name,
                    rating: doctor.reviews[index].rating.toString(),
                    review: doctor.reviews[index].content,
                  ),
                  separatorBuilder: (_, index) => SizedBox(height: 1.5.h),
                ),
                SizedBox(height: 0.5.h),
              ],
            );
          } else {
            return const Center(child: Text('No data found'));
          }
        },
      ),
    );
  }
}
