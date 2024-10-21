import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

part 'pick_image_state.dart';

class PickImageCubit extends Cubit<PickImageState> {
  File? image;
  final ImagePicker _picker = ImagePicker();
  PickImageCubit() : super(PickImageInitial());

  // ! Pick image from gallery
  Future<void> pickImageFromGallery() async {
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile == null) return;
    image = File(pickedFile.path);
    emit(PickImageSuccess(image!));
  }
}
