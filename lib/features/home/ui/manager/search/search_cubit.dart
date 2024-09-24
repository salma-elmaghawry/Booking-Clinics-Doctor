import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:booking_clinics_doctor/data/models/doctor_model.dart';
import '../../../data/repo/home_repo.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final HomeRepo repo;
  SearchCubit(this.repo) : super(SearchInitial());

  Future<void> findDoctors(String query) async {
    emit(SearchLoading());
    final result = await repo.findDoctors(query);
    result.fold(
      (failure) {
        emit(SearchFailure(failure.ex));
      },
      (doctors) {
        emit(SearchSuccess(doctors));
      },
    );
  }
}
