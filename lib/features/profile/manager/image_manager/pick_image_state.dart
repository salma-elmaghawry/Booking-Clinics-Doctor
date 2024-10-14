part of 'pick_image_cubit.dart';

sealed class PickImageState {
  const PickImageState();
}

final class PickImageInitial extends PickImageState {}

final class PickImageSuccess extends PickImageState {
  final File image;
  const PickImageSuccess(this.image);
}
