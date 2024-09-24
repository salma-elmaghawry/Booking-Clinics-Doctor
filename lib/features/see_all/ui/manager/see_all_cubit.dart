import '../../data/see_all_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:booking_clinics_doctor/data/models/doctor_model.dart';

part 'see_all_state.dart';

class SeeAllCubit extends Cubit<SeeAllState> {
  final SeeAllRepo seeAllRepo;
  SeeAllCubit(this.seeAllRepo) : super(SeeAllInitial());

  Future<void> invokeAllDoctors() async {
    emit(SeeAllLoading());
    final result = await seeAllRepo.getAllDoctors();
    result.fold(
      (failure) {
        emit(
          SeeAllFailure(error: failure.ex),
        );
      },
      (doctors) {
        emit(SeeAllSuccess(doctors: doctors));
      },
    );
  }

  Future<void> invokeBySpecialty(String specialty) async {
    emit(SeeAllLoading());
    final result = await seeAllRepo.getDoctorsBySpecialty(specialty);
    result.fold(
      (failure) {
        emit(SeeAllFailure(error: failure.ex));
      },
      (doctors) {
        emit(SeeAllSuccess(doctors: doctors));
      },
    );
  }
}
