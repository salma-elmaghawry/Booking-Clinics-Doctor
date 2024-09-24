part of 'all_doctors_cubit.dart';

sealed class AllDoctorsState {
  const AllDoctorsState();
}

final class AllDoctorsInitial extends AllDoctorsState {}

final class AllDoctorsSuccess extends AllDoctorsState {
  final List<DoctorModel> doctors;
  const AllDoctorsSuccess(this.doctors);
}

final class AllDoctorsLoading extends AllDoctorsState {}

final class AllDoctorsFailure extends AllDoctorsState {
  final String error;
  const AllDoctorsFailure(this.error);
}
