import 'package:sizer/sizer.dart';
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
              onTap: (val) async {
                await mapCubit.getDoctors();
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
                  mapCubit
                    ..places.clear()
                    ..sessionToken = null
                    ..textController.clear();
                  List<LatLng> points = await mapCubit.computeRoutes(details);
                  await mapCubit.displayRoutes(points);
                  // await mapCubit.trackLocation();
                },
              ),
            ),
          ],
        );
      },
    );
  }
}

        // bottomSheet: MapsButtomSheet(
        //   controller: mapCubit.textController,
        //   onSelectPlace: (details) async {
        //     mapCubit
        //       ..places.clear()
        //       ..sessionToken = null
        //       ..textController.clear();
        //     List<LatLng> points = await mapCubit.computeRoutes(details);
        //     await mapCubit.displayRoutes(points);
        //   },
        // ),

/*
BlocBuilder<HomeCubit, HomeState>(
        builder: (_, state) {
          if (state is HomeSuccessState) {
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemCount: state.model.data!.serviceType!.length,
              itemBuilder: (_, index) {
                return Text(state.model.data!.serviceType![index].type);
              },
            );
          } else if (state is HomeFailureState) {
            return Center(child: Text(state.error));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      )
*/
