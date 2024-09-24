part of "doc_details_cubit.dart";

abstract class DoctorState {}

class DoctorInitial extends DoctorState {}

class DoctorLoading extends DoctorState {}

class DoctorLoaded extends DoctorState {
  DoctorLoaded(this.doctors);
  final List<DoctorModel> doctors;
}

class DoctorError extends DoctorState {
  final String error;
  DoctorError(this.error);
}

// ! states favourite
class LikedState extends DoctorState {}

class UnLikedState extends DoctorState {}

class DoctorFavoritesLoaded extends DoctorState {
  final List<Favorite> favorites;
  DoctorFavoritesLoaded(this.favorites);
}

class DoctorFavoritesError extends DoctorState {
  final String error;
  DoctorFavoritesError(this.error);
}
