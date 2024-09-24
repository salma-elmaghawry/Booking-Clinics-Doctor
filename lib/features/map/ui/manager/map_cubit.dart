import 'dart:math';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import '../../../../data/models/doctor_model.dart';
import '../../data/model/location_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repo/map_repo/map_repo.dart';
import '../../data/repo/routes_repo/routes_repo.dart';
import '../../data/model/routes_model/routes_model.dart';
import '../../data/repo/location_repo/location_repo.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import '../../data/model/place_details_model/place_details_model.dart';
import '../../data/model/place_autocomplete_model/place_autocomplete_model.dart';

part 'map_state.dart';

class MapCubit extends Cubit<MapState> {
  MapCubit({
    required this.mapRepo,
    required this.routesRepo,
    required this.locationRepo,
  }) : super(MapInitial()) {
    _uuid = const Uuid();
    textController = TextEditingController();
  }

  final MapRepo mapRepo;
  final RoutesRepo routesRepo;
  final LocationRepo locationRepo;

  Timer? debounce;
  // LatLng? _latLng;
  String? sessionToken;
  late final Uuid _uuid;
  bool _isFirstCall = true;
  final Set<Marker> markers = {};
  final Set<Polyline> polylines = {};
  late final GoogleMapController mapController;
  final List<PlaceAutocompleteModel> places = [];
  late final TextEditingController textController;

  Future<void> getDoctors() async {
    try {
      BitmapDescriptor icon = await _setupCustomMarker();
      final QuerySnapshot query =
          await FirebaseFirestore.instance.collection('doctors').get();
      final List<DoctorModel> doctors = query.docs.map((doc) {
        print(doc.id);
        return DoctorModel.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();
      print("Hello");
      if (doctors.isNotEmpty) {
        for (int i = 0; i < doctors.length; i++) {
          markers.add(
            Marker(
              icon: icon,
              markerId: MarkerId(doctors[i].id),
              position: LatLng(
                doctors[i].location["latitude"],
                doctors[i].location["longitude"],
              ),
              infoWindow: InfoWindow(title: doctors[i].name),
            ),
          );
        }
      }
    } catch (e) {
      print(e);
      emit(MapFailure("fetch doctors failed"));
    }
  }

  // ! styling map
  Future<String> setupMapStyle(BuildContext context) async {
    return await DefaultAssetBundle.of(context).loadString(
      "assets/map_style/default.json",
    );
  }

  // ! styling markers
  Future<BitmapDescriptor> _setupCustomMarker() async {
    return await BitmapDescriptor.asset(
      ImageConfiguration.empty,
      "assets/images/marker.png",
    );
  }

  // ! Feature(0)
  Future<bool> checkPermissions() async {
    bool enabled = await locationRepo.checkLocationService();
    bool allowed = await locationRepo.askPermission();
    return enabled && allowed;
  }

  // ! Feature(1)
  Future<void> myLocation() async {
    if (await checkPermissions()) {
      emit(MapLoading());
      final result = await locationRepo.getLocation();
      result.fold(
        (failure) => emit(MapFailure(failure.ex)),
        (success) async {
          // _latLng = LatLng(success!.latitude!, success.longitude!);
          markers.add(
            Marker(
              markerId: const MarkerId('my_location'),
              position: LatLng(success!.latitude!, success.longitude!),
              infoWindow: const InfoWindow(title: 'My location'),
            ),
          );
          await mapController.animateCamera(
            CameraUpdate.newLatLngZoom(
              LatLng(success.latitude!, success.longitude!),
              12,
            ),
          );
          await getDoctors();
          emit(MapSuccess());
        },
      );
    } else {
      emit(MapFailure("Allow permissions to use google maps."));
    }
  }

  // ! Feature(2-1): Search on place.
  void predectPlaces() {
    textController.addListener(() {
      if (debounce?.isActive ?? false) debounce?.cancel();
      debounce = Timer(
        const Duration(milliseconds: 300),
        () async {
          sessionToken ??= _uuid.v4();
          if (textController.text.trim().isNotEmpty) {
            final result = await mapRepo.predections(
              input: textController.text,
              sessionToken: sessionToken!,
            );
            result.fold(
              (failure) => emit(MapFailure(failure.ex)),
              (success) {
                if (success != null) {
                  places
                    ..clear()
                    ..addAll(success);
                  emit(MapSuccess());
                }
              },
            );
          } else {
            places.clear();
            emit(MapSuccess());
          }
        },
      );
    });
  }

  // ! Feature(2-2): onClick response coming from [predectPlaces].
  Future<List<LatLng>> computeRoutes(PlaceDetailsModel? details) async {
    // print(markers.first.position.latitude);
    emit(MapLoading());
    final result = await routesRepo.computeRoutes(
      origin: LocationModel(
        lat: markers.first.position.latitude,
        lng: markers.first.position.longitude,
      ),
      destination: LocationModel(
        lat: details!.geometry!.location!.lat!,
        lng: details.geometry!.location!.lng!,
      ),
    );
    List<LatLng> routes = [];
    result.fold(
      (failure) => emit(MapFailure(failure.ex)),
      (success) {
        routes = _decodeLatLng(success)
            .map((e) => LatLng(e.latitude, e.longitude))
            .toList();
      },
    );
    return routes;
  }

// ! Feature(2-3): after [fetchRoutes] decode polyline in it's response.
  List<PointLatLng> _decodeLatLng(RoutesModel? data) {
    PolylinePoints polylinePoints = PolylinePoints();
    if (data != null && data.routes != null) {
      return polylinePoints.decodePolyline(
        data.routes!.first.polyline!.encodedPolyline!,
      );
    } else {
      return [];
    }
  }

  // ! Feature(2-4): send decoded polyline in request to get routes.
  Future<PlaceDetailsModel?> placeDetails(String placeId) async {
    emit(MapLoading());
    final result = await mapRepo.placeDetails(placeId: placeId);
    PlaceDetailsModel? placeDetailsModel;
    result.fold(
      (failure) => emit(MapFailure(failure.ex)),
      (success) {
        placeDetailsModel = success;
        emit(MapSuccess());
      },
    );
    return placeDetailsModel;
  }

  // ! Feature(2-5): finally, display decoded polyline on the map.
  Future<void> displayRoutes(List<LatLng> points) async {
    final Polyline route = Polyline(
      width: 3,
      points: points,
      color: Colors.blue,
      polylineId: const PolylineId("route"),
    );
    polylines.add(route);
    if (points.isNotEmpty) {
      await mapController.animateCamera(
        CameraUpdate.newLatLngBounds(_latLngBounds(points), 5.w),
      );
      emit(MapSuccess());
    } else {
      emit(MapFailure("Are you crazy?!"));
    }
  }

  // ! Feature(2-6): Update camera bounds after searching in place.
  LatLngBounds _latLngBounds(List<LatLng> points) {
    double southLat = points.first.latitude;
    double southLng = points.first.longitude;
    double northLat = points.first.latitude;
    double northLng = points.first.longitude;
    for (LatLng point in points) {
      southLat = min(southLat, point.latitude);
      southLng = min(southLng, point.longitude);
      northLat = min(northLat, point.latitude);
      northLat = min(northLat, point.longitude);
    }
    return LatLngBounds(
      southwest: LatLng(southLat, southLng),
      northeast: LatLng(northLat, northLng),
    );
  }

  // ! Featur(3): Track Current Location in real time.
  Future<void> trackLocation() async {
    await myLocation();
    await locationRepo.getRealTimeLocation(
      (_) async {
        debugPrint("${markers.length} ------------------------------------");
        markers.add(
          Marker(
            markerId: const MarkerId('my_location_marker'),
            position: LatLng(
              markers.first.position.latitude,
              markers.first.position.longitude,
            ),
            infoWindow: const InfoWindow(title: 'My current location'),
          ),
        );
        emit(MapSuccess());
        if (_isFirstCall) {
          await mapController.animateCamera(
            CameraUpdate.newCameraPosition(
              const CameraPosition(
                zoom: 14,
                target: LatLng(32.430833635256974, 46.26442871931941),
              ),
            ),
          );
          _isFirstCall = !_isFirstCall;
        } else {
          await mapController.animateCamera(
            CameraUpdate.newLatLng(
              LatLng(
                markers.first.position.latitude,
                markers.first.position.longitude,
              ),
            ),
          );
        }
      },
    );
  }

  @override
  Future<void> close() {
    textController.removeListener(predectPlaces);
    textController.dispose();
    debounce?.cancel();
    // SystemChrome.setEnabledSystemUIMode(
    //   SystemUiMode.manual,
    //   overlays: SystemUiOverlay.values,
    // );
    return super.close();
  }
}
