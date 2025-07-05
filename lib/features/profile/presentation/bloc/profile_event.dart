part of 'profile_bloc.dart';

class ProfileEvent {}

class GetProfileEvent extends ProfileEvent {}

class UpdateProfileEvent extends ProfileEvent {
  final UpdateUserModelParams params;
  UpdateProfileEvent({required this.params});
}
