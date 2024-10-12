import 'package:dio/dio.dart';
import '../../../../../core/helper/service_locator.dart';
import 'map_repo.dart';
import 'package:dartz/dartz.dart';
import '../../../../../core/helper/failure.dart';
import '../../model/place_details_model/place_details_model.dart';
import '../../model/place_autocomplete_model/place_autocomplete_model.dart';

class MapImpl implements MapRepo {
  static const String _key = "AIzaSyAhzcjsGHGz0BSvhrNnSzeO8uSRSdm1tQU";
  static const String _baseUrl = 'https://maps.googleapis.com/maps/api/place';

  @override
  Future<Either<Failure, List<PlaceAutocompleteModel>?>> predections({
    required String input,
    required String sessionToken,
  }) async {
    try {
      Response<Map<String, dynamic>>? response = await getIt.get<Dio>().post(
          "$_baseUrl/autocomplete/json?input=$input&type=health&region=eg&sessiontoken=$sessionToken&key=$_key");
      List? data = response.data?["predictions"];
      List<PlaceAutocompleteModel> places = [];
      if (data != null) {
        for (Map<String, dynamic> place in data) {
          places.add(PlaceAutocompleteModel.fromJson(place));
        }
      }
      return right(places);
    } catch (e) {
      return left(UnknownFailure("$e"));
    }
  }

  @override
  Future<Either<Failure, PlaceDetailsModel?>> placeDetails({
    required String placeId,
  }) async {
    try {
      Response? response = await getIt
          .get<Dio>()
          .post("$_baseUrl/details/json?place_id=$placeId&key=$_key");
      return right(PlaceDetailsModel.fromJson(response.data?["result"]));
    } catch (e) {
      return left(UnknownFailure("$e"));
    }
  }
}
