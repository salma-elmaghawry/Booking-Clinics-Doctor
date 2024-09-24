import 'package:dartz/dartz.dart';
import '../../../../../core/helper/failure.dart';
import '../../model/place_details_model/place_details_model.dart';
import '../../model/place_autocomplete_model/place_autocomplete_model.dart';

abstract class MapRepo {
  Future<Either<Failure, List<PlaceAutocompleteModel>?>> predections({
    required String input,
    required String sessionToken,
  });

  Future<Either<Failure, PlaceDetailsModel?>> placeDetails({
    required String placeId,
  });
}
