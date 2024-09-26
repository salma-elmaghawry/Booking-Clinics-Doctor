import 'dart:io';
import 'package:booking_clinics_doctor/data/models/doctor_model.dart';
import 'package:path/path.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:booking_clinics_doctor/data/services/remote/firebase_auth.dart';
import '../../../auth/data/auth_services.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  File? image;
  String? downLoadUrl;
  final FirebaseAuthService _service;
  ProfileCubit(this._service) : super(ProfileInitial());
  final AuthenticationServices _authServices = AuthenticationServices();
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // ! get user data from firestore
  Future<void> getUserData() async {
    emit(ProfileLoading());
    try {
      final String? uid = await _authServices.getUid();
      debugPrint("$uid _______________");
      final DocumentSnapshot doc = await _firestore.collection('doctors').doc(uid).get();
      debugPrint("$doc _______________doc");
      if (doc.exists) {
        final data = doc.data() as Map<String, dynamic>;
        emit(ProfileSuccess(DoctorModel.fromJson(data)));
      } else {
        emit(const ProfileFailure('User not found'));
      }
    } catch (e) {
      debugPrint("$e");
      emit(const ProfileFailure("Oops... Something went wrong!"));
    }
  }

  // ! upload image to storage
  Future<void> uploadImage() async {
    emit(UpdateProfileLoading());
    try {
      if (image == null) return;
      String fileName = basename(image!.path);
      FirebaseStorage storage = FirebaseStorage.instanceFor(
        bucket: "gs://doctor-app-30d61.appspot.com",
      );
      Reference ref = storage.ref().child("profile_image/$fileName");
      UploadTask task = ref.putFile(image!);
      await task.whenComplete(() async => null);
      downLoadUrl = await ref.getDownloadURL();
    } catch (e) {
      debugPrint("$e");
    }
  }

  // ! Update user data
  Future<void> updateUserData(Map<String, dynamic> data) async {
    try {
      emit(UpdateProfileLoading());
      final String? uid = await _authServices.getUid();
      await _firestore.collection('doctors').doc(uid).update(data);

      image = null;
      downLoadUrl = null;
      emit(UpdateProfileSuccess());
    } catch (e) {
      debugPrint("$e");
      emit(const UpdateProfileFailure("Oops... Something went wrong!"));
    }
  }
}
