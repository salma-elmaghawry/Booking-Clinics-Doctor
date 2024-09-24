import 'package:sizer/sizer.dart';
import 'package:iconsax/iconsax.dart';
import 'package:flutter/material.dart';
import '../manager/search/search_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constant/const_string.dart';
import 'package:booking_clinics_doctor/core/constant/extension.dart';
import 'package:booking_clinics_doctor/core/constant/const_color.dart';

class CustomSearch extends SearchDelegate {
  @override
  String? get searchFieldLabel => "Search for doctors...";

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () async {
          if (query.isEmpty) return;
          showResults(context);
          await context.read<SearchCubit>().findDoctors(query);
        },
        icon: const Icon(Iconsax.search_normal),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () => close(context, null),
      icon: const Icon(Iconsax.arrow_left_2),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: BlocBuilder<SearchCubit, SearchState>(
          builder: (_, state) {
            if (state is SearchSuccess) {
              if (state.doctors.isEmpty) {
                return Center(
                  child: Text(
                    "No results found for $query",
                    style: context.medium14,
                  ),
                );
              }
              return ListView.builder(
                padding: EdgeInsets.symmetric(vertical: 1.h),
                itemCount: state.doctors.length,
                itemBuilder: (_, index) => ListTile(
                  onTap: () async {
                    await _onChooseDoc(context, state, index);
                  },
                  contentPadding: EdgeInsets.only(left: 6.w, right: 1.5.w),
                  title: Row(
                    children: [
                      Text(
                        "${state.doctors[index].name},",
                        style: context.medium16,
                      ),
                      SizedBox(width: 2.w),
                      Text(
                        state.doctors[index].speciality,
                        style: context.regular14?.copyWith(
                          color: ConstColor.icon.color,
                        ),
                      ),
                    ],
                  ),
                  subtitle: Text(
                    state.doctors[index].address ?? "",
                    style: context.regular14?.copyWith(
                      color: ConstColor.icon.color,
                    ),
                  ),
                  trailing: IconButton(
                    onPressed: () async {
                      await _onChooseDoc(context, state, index);
                    },
                    icon: const Icon(Iconsax.arrow_circle_right),
                  ),
                ),
              );
            } else if (state is SearchFailure) {
              return Center(
                child: Text(
                  "Oops... Something went wrong!",
                  style: context.regular14,
                ),
              );
            } else if (state is SearchLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return const SizedBox.expand();
            }
          },
        ),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) => buildResults(context);

  Future<void> _onChooseDoc(
      BuildContext context, SearchSuccess state, int index) async {
    close(context, null);
    await context.nav.pushNamed(
      Routes.doctorDetailsRoute,
      arguments: {
        "doctorId": state.doctors[index].id,
        "patientName": state.doctors[index].name,
      },
    );
  }
}
