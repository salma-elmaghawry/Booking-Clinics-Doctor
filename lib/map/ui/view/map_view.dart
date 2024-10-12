import 'package:booking_clinics_doctor/core/constant/extension.dart';
import 'package:booking_clinics_doctor/features/home/ui/widget/list_item.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/constant/const_string.dart';
import '../../data/model/location_model.dart';
import '../manager/map_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../widget/map_input.dart';

class MapView extends StatefulWidget {
  const MapView({super.key});

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  String? style;
  @override
  void initState() {
    super.initState();
    context.read<MapCubit>().setupMapStyle(context).then((val) {
      style = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    final mapCubit = context.read<MapCubit>();
    return BlocBuilder<MapCubit, MapState>(
      builder: (_, state) {
        return Stack(
          children: [
            GoogleMap(
              style: style,
              markers: mapCubit.markers,
              onTap: (val) {
                if (state is MapLoading) return;
                if (state is MarkerClicked) mapCubit.emitInitial();
              },
              onMapCreated: (controller) async {
                // style = await mapCubit.setupMapStyle(context);
                mapCubit.mapController = controller;
                await mapCubit.myLocation();
                // mapCubit.predectPlaces();
              },
              compassEnabled: false,
              zoomControlsEnabled: false,
              polylines: mapCubit.polylines,
              initialCameraPosition: const CameraPosition(
                zoom: 1,
                target: LatLng(32.430833635256974, 46.26442871931941),
              ),
            ),
            Positioned(
              top: 6.5.h,
              left: 4.w,
              right: 4.w,
              child: MapInput(
                onSelectPlace: (details) async {
                  await _computeRoute(
                    mapCubit,
                    LocationModel(
                      lat: details!.geometry!.location!.lat!,
                      lng: details.geometry!.location!.lng!,
                    ),
                  );
                  // await mapCubit.trackLocation();
                },
              ),
            ),
            if (state is MarkerClicked)
              Positioned(
                left: 4.w,
                right: 4.w,
                bottom: 10.h,
                height: 30.h,
                child: GestureDetector(
                  onTap: () {
                    context.nav.pushNamed(
                      Routes.doctorDetailsRoute,
                      arguments: {
                        "doctorId": state.model.id,
                        "patientName": state.model.name,
                      },
                    );
                  },
                  child: Card(
                    child: ListItem(
                      doctor: state.model,
                      computeRoute: () async => await _computeRoute(
                        mapCubit,
                        LocationModel(
                          lat: state.model.location["lat"],
                          lng: state.model.location["lng"],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            if (state is MapLoading)
              const Center(child: CircularProgressIndicator()),
          ],
        );
      },
    );
  }

  Future<void> _computeRoute(
    MapCubit mapCubit,
    LocationModel? destination,
  ) async {
    if (destination == null) return;
    mapCubit
      ..places.clear()
      ..sessionToken = null
      ..textController.clear();
    List<LatLng> points = await mapCubit.computeRoutes(destination);
    await mapCubit.displayRoutes(points);
  }
}
