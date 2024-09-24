import 'package:dartz/dartz.dart';
import 'package:location/location.dart';
import '../../../../../core/helper/failure.dart';

abstract class LocationRepo {
  Future<bool> checkLocationService();
  Future<bool> askPermission();
  Future<Either<Failure, void>> getRealTimeLocation(
    void Function(LocationData)? onData,
  );
  Future<Either<Failure, LocationData?>> getLocation();
}

// ? Get Location Once, or Tracking in Real Time.
// 1- Inquire about location service. // ? [check location service]
// 2- check permission. // ? [ask for location permission]
// 3- Get location. // ? [track in real time / get current location once]
// 4- Display & Upadate location. // ? [finaly... UI]
