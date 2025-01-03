import 'package:dartz/dartz.dart';
import '../../../../core/helper/failure.dart';
import 'package:booking_clinics_doctor/data/models/doctor_model.dart';

abstract class HomeRepo {
  Future<Either<Failure, List<DoctorModel>>> findDoctors(String query);
}
