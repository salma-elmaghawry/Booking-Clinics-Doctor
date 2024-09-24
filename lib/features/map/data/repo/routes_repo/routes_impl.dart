import 'package:dio/dio.dart';
import '../../../../../core/helper/service_locator.dart';
import 'routes_repo.dart';
import 'package:dartz/dartz.dart';
import '../../model/location_model.dart';
import '../../../../../core/helper/failure.dart';
import '../../model/routes_model/routes_model.dart';
import '../../model/routes_model/routes_modifiers_model.dart';

class RoutesImpl implements RoutesRepo {
  static const _key = "AIzaSyAAsMPuT0Yj2VhMabfuv7glNqPU3phJScg";
  static const _baseUrl =
      "https://routes.googleapis.com/directions/v2:computeRoutes";

  @override
  Future<Either<Failure, RoutesModel?>> computeRoutes({
    required LocationModel origin,
    required LocationModel destination,
    RoutesModifiersModel? routeModifiers,
  }) async {
    try {
      Response? response = await getIt.get<Dio>().post(
            _baseUrl,
            data: {
              "origin": {
                "location": {"latLng": origin.toJson()}
              },
              "destination": {
                "location": {"latLng": destination.toJson()}
              },
            }.toString(),
            options: Options(
              headers: {
                "Content-Type": "application/json",
                "X-Goog-Api-Key": _key,
                "X-Goog-FieldMask":
                    "routes.duration,routes.distanceMeters,routes.polyline.encodedPolyline",
              },
            ),
          );
      return right(RoutesModel.fromJson(response.data));
    } catch (e) {
      return left(UnknownFailure("$e"));
    }
  }
}
