part of 'profile_bloc.dart';

class ProfileState {}

final class ProfileInitial extends ProfileState {}

class GetProfileLoadingState extends ProfileState {}

class GetProfileSuccessState extends ProfileState {}

final class UpdateProfileLoadingState extends ProfileState {}

final class UpdateProfileSuccessState extends ProfileState {}

class ProfileErrorState extends ProfileState {
  final String message;
  ProfileErrorState({required this.message});
}
