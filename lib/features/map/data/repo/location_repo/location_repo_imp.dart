import '../../../../../core/helper/failure.dart';
import 'location_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:location/location.dart';

final class LocationImpl implements LocationRepo {
  final Location _location;
  const LocationImpl(this._location);

  @override
  Future<bool> askPermission() async {
    bool isEnabled = await _location.serviceEnabled();
    if (!isEnabled) {
      isEnabled = await _location.requestService();
      if (!isEnabled) {}
    }
    return isEnabled;
  }

  @override
  Future<bool> checkLocationService() async {
    PermissionStatus status = await _location.hasPermission();
    if (status == PermissionStatus.deniedForever) {
      return false;
    } else if (status == PermissionStatus.denied) {
      status = await _location.requestPermission();
      return status == PermissionStatus.granted;
    }
    return true;
  }

  @override
  Future<Either<Failure, LocationData?>> getLocation() async {
    try {
      final response = await _location.getLocation();
      return right(response);
    } catch (e) {
      return left(UnknownFailure("$e"));
    }
  }

  @override
  Future<Either<Failure, void>> getRealTimeLocation(
    void Function(LocationData param)? onData,
  ) async {
    try {
      await _location.changeSettings(distanceFilter: 2);
      _location.onLocationChanged.listen(onData);
      return right(null);
    } catch (e) {
      return left(UnknownFailure("$e"));
    }
  }
}
