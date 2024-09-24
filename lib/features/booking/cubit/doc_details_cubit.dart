import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../data/models/doctor_model.dart';
import '../../../../data/models/favorite.dart';
import '../../../../data/services/remote/firebase_auth.dart';
import '../../../../data/services/remote/firebase_firestore.dart';

part 'doc_details_state.dart';

class DoctorCubit extends Cubit<DoctorState> {
  List<Favorite> _favorites = [];
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

  Future<void> toggleDoctorFavoriteStatus(DoctorModel doctor) async {
    try {
      var patientId = await FirebaseAuthService().getUid();
      final favorite = Favorite(
        docName: doctor.name,
        docAddress: doctor.address ?? 'Unknown Address',
        docSpeciality: doctor.speciality,
        docImageUrl: doctor.imageUrl ?? '',
        rating: doctor.rating ?? 0.0,
        reviewsNumber: doctor.reviews.length,
        isFavorite: true,
      );

      final favorites = await _firebaseFirestoreService.getFavoritesForPatient(
        patientId!,
      );

      if (favorites.any((fav) => fav.docName == favorite.docName)) {
        await _firebaseFirestoreService.removeFavoriteFromPatient(
          patientId,
          favorite,
        );
      } else {
        await _firebaseFirestoreService.addFavoriteToPatient(
          patientId,
          favorite,
        );
      }
      await fetchFavorites(patientId); // update
      final updatedDoctor =
          await _firebaseFirestoreService.getDoctorById(doctor.id);
      emit(DoctorLoaded([updatedDoctor!]));
    } catch (e) {
      emit(DoctorError('Failed to toggle favorite status: $e'));
    }
  }

  Future<void> fetchFavorites(String patientId) async {
    try {
      _favorites = await _firebaseFirestoreService.getFavoritesForPatient(
        patientId,
      );
      print(_favorites);
      // emit(DoctorFavoritesLoaded(_favorites));
    } catch (e) {
      emit(DoctorError('Failed to load favorites: $e'));
    }
  }

  bool isFavoriteDoctor(String doctorName) {
    final bool test = _favorites.any((fav) => fav.docName == doctorName);
    print(test);
    return test;
  }
}
