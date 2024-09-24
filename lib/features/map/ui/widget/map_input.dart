import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/common/input.dart';
import '../../data/model/place_details_model/place_details_model.dart';
import '../manager/map_cubit.dart';

class MapInput extends StatelessWidget {
  const MapInput({required this.onSelectPlace, super.key});
  final Future Function(PlaceDetailsModel?) onSelectPlace;
  Future<void> _onClick(BuildContext context, int index) async {
    final details = await context.read<MapCubit>().placeDetails(
          "${context.read<MapCubit>().places[index].placeId}",
        );
    await onSelectPlace(details);
  }

  @override
  Widget build(BuildContext context) {
    final MapCubit mapCubit = context.read<MapCubit>();
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          decoration: const BoxDecoration(
            boxShadow: [
              // BoxShadow(
              //   color: Colors.black12,
              //   offset: Offset(0, 4),
              //   blurRadius: 4,
              // ),
            ],
          ),
          child: Input(
            fillColor: Colors.white,
            hint: "Search Doctor, Hospital",
            controller: mapCubit.textController,
            prefix: Iconsax.search_normal,
          ),
        ),
        AnimatedContainer(
          constraints: BoxConstraints(
            minHeight: 0,
            maxHeight: 40.h,
            minWidth: double.infinity,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(3.5.w),
          ),
          margin: EdgeInsets.only(top: 1.h),
          duration: const Duration(milliseconds: 200),
          child: ListView.separated(
            itemCount: mapCubit.places.length,
            shrinkWrap: true,
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            itemBuilder: (_, index) {
              return ListTile(
                onTap: () => _onClick(context, index),
                title: Text(mapCubit.places[index].terms?.first.value ?? ""),
                subtitle: Text(mapCubit.places[index].description ?? ""),
              );
            },
            separatorBuilder: (_, index) => const Divider(
              height: 0,
              color: Color(0xffE5E7EB),
            ),
          ),
        ),
      ],
    );
  }
}
