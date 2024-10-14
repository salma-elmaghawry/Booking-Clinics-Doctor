import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/common/input.dart';
import '../../../../core/helper/snackbar.dart';
import '../../data/model/place_details_model/place_details_model.dart';
import '../manager/map_cubit.dart';

class MapsButtomSheet extends StatelessWidget {
  final TextEditingController controller;
  const MapsButtomSheet({
    required this.controller,
    required this.onSelectPlace,
    super.key,
  });
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
    return Padding(
      padding: EdgeInsets.only(left: 4.5.w, top: 2.5.h, right: 4.5.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Input(
                  controller: controller,
                  hint: "Where to go?",
                  // prefix: SvgPicture.asset("assets/icons"),
                ),
              ),
              SizedBox(width: 4.w),
              CircleAvatar(
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.car_rental),
                ),
              ),
            ],
          ),
          Expanded(
            child: BlocConsumer<MapCubit, MapState>(
              listener: (_, state) {
                if (state is MapFailure) {
                  showSnackBar(
                    context,
                    title: state.error,
                    icon: Icons.error,
                    color: Colors.red,
                  );
                }
              },
              builder: (_, state) {
                if (state is MapSuccess && mapCubit.places.isNotEmpty) {
                  return ListView.separated(
                    shrinkWrap: true,
                    itemCount: mapCubit.places.length,
                    padding: EdgeInsets.symmetric(horizontal: 2.w),
                    itemBuilder: (_, index) {
                      return ListTile(
                        dense: true,
                        onTap: () async {
                          await _onClick(context, index);
                        },
                        contentPadding: EdgeInsets.zero,
                        title: Text(mapCubit.places[index].description ?? ""),
                        trailing: GestureDetector(
                          onTap: () async {
                            await _onClick(context, index);
                          },
                          child: const Icon(Icons.arrow_circle_right_outlined),
                        ),
                      );
                    },
                    separatorBuilder: (_, index) => const Divider(height: 0),
                  );
                } else if (mapCubit.places.isEmpty) {
                  return Align(
                    alignment: const Alignment(0, -1.4),
                    child: SvgPicture.asset(
                      "assets/images/maps.svg",
                      height: 22.h,
                    ),
                  );
                } else {
                  return const Center(child: Text(""));
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
