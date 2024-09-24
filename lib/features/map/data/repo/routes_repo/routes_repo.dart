import 'package:dartz/dartz.dart';
import '../../model/location_model.dart';
import '../../../../../core/helper/failure.dart';
import '../../model/routes_model/routes_model.dart';
import '../../model/routes_model/routes_modifiers_model.dart';

abstract class RoutesRepo {
  Future<Either<Failure, RoutesModel?>> computeRoutes({
    required LocationModel origin,
    required LocationModel destination,
    RoutesModifiersModel? routeModifiers,
  });
}
