import 'package:dartz/dartz.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:booking_clinics_doctor/core/helper/failure.dart';
import 'package:booking_clinics_doctor/data/models/doctor_model.dart';

import 'home_repo.dart';

class HomeRepoImpl implements HomeRepo {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<Either<Failure, List<DoctorModel>>> findDoctors(String query) async {
    try {
      final String capitalizeQuery = _capitalizeEachWord(query);
      final QuerySnapshot snapshot = await _firestore
          .collection('doctors')
          .where("name", isGreaterThanOrEqualTo: capitalizeQuery)
          .where("name", isLessThanOrEqualTo: '$capitalizeQuery\uf8ff')
          .get();
      final List<DoctorModel> doctors = snapshot.docs.map((doc) {
        return DoctorModel.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();
      return right(doctors);
    } catch (e) {
      return left(UnknownFailure("$e"));
    }
  }

  String _capitalizeEachWord(String sentence) {
    if (sentence.isEmpty) return sentence;
    List<String> words = sentence.split(' ');
    List<String> capitalizedWords = words.map((word) {
      if (word.isEmpty) return word;
      return word[0].toUpperCase() + word.substring(1).toLowerCase();
    }).toList();
    return capitalizedWords.join(' ');
  }
}
