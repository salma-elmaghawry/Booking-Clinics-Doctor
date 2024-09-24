part of 'profile_cubit.dart';

sealed class ProfileState {
  const ProfileState();
}

// ! States for profile page
final class ProfileInitial extends ProfileState {}

final class ProfileLoading extends ProfileState {}

final class ProfileSuccess extends ProfileState {
  final Patient model;
  const ProfileSuccess(this.model);
}

final class ProfileFailure extends ProfileState {
  final String error;
  const ProfileFailure(this.error);
}

// ! States for edit page
final class UpdateProfileInitial extends ProfileState {}

final class UpdateProfileLoading extends ProfileState {}

final class UpdateProfileSuccess extends ProfileState {}

final class UpdateProfileFailure extends ProfileState {
  final String error;
  const UpdateProfileFailure(this.error);
}
