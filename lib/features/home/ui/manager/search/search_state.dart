part of 'search_cubit.dart';

sealed class SearchState {
  const SearchState();
}

final class SearchInitial extends SearchState {}

final class SearchLoading extends SearchState {}

final class SearchSuccess extends SearchState {
  final List<DoctorModel> doctors;
  const SearchSuccess(this.doctors);
}

final class SearchFailure extends SearchState {
  final String error;
  const SearchFailure(this.error);
}
