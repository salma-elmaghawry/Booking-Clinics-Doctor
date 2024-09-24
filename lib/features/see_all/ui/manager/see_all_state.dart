part of 'see_all_cubit.dart';

sealed class SeeAllState {
  const SeeAllState();
}

final class SeeAllInitial extends SeeAllState {}

final class SeeAllLoading extends SeeAllState {}

final class SeeAllSuccess extends SeeAllState {
  final List<DoctorModel> doctors;
  const SeeAllSuccess({required this.doctors});
}

final class SeeAllFailure extends SeeAllState {
  final String error;
  const SeeAllFailure({required this.error});
}
