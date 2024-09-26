import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../data/models/doctor_model.dart';
import '../../../../data/models/favorite.dart';
import '../../../../data/services/remote/firebase_firestore.dart';

part 'doc_details_state.dart';

class DoctorCubit extends Cubit<DoctorState> {
  final FirebaseFirestoreService _firebaseFirestoreService;
  DoctorCubit(this._firebaseFirestoreService) : super(DoctorInitial());

  Future<void> fetchDoctorById(String doctorId) async {
    try {
      emit(DoctorLoading());
      final doctor = await _firebaseFirestoreService.getDoctorById(doctorId);
      if (doctor != null) {
        emit(DoctorLoaded([doctor]));
      } else {
        emit(DoctorError('Doctor not found'));
      }
    } catch (e) {
      emit(DoctorError('Failed to load doctor: $e'));
    }
  }
}
