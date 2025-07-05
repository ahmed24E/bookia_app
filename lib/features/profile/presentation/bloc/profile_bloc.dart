import 'package:bookia_app/features/profile/data/model/request/edit_user_model_params.dart';
import 'package:bookia_app/features/profile/data/model/response/get_profile_response/get_profile_response.dart';
import 'package:bookia_app/features/profile/data/repo/profile_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {
    on<GetProfileEvent>(getProfile);
    on<UpdateProfileEvent>(updateProfile);
  }

  GetProfileResponse? profileResponse;
  Future<void> getProfile(
      GetProfileEvent event, Emitter<ProfileState> emit) async {
    emit(GetProfileLoadingState());

    try {
      await ProfileRepo.getProfile().then((value) {
        if (value != null) {
          profileResponse = value;
          emit(GetProfileSuccessState());
        } else {
          emit(ProfileErrorState(
              message: 'Unexpected Error occur, please try again'));
        }
      });
    } on Exception {
      emit(ProfileErrorState(
          message: 'Unexpected Error occur, please try again'));
    }
  }

  Future<void> updateProfile(
      UpdateProfileEvent event, Emitter<ProfileState> emit) async {
    emit(UpdateProfileLoadingState());
    try {
      await ProfileRepo.updateProfile(event.params).then((value) {
        if (value) {
          emit(UpdateProfileSuccessState());
        } else {
          emit(ProfileErrorState(
              message: 'Unexpected Error occur, please try again'));
        }
      });
    } on Exception {
      emit(ProfileErrorState(
          message: 'Unexpected Error occur, please try again'));
    }
  }
}
