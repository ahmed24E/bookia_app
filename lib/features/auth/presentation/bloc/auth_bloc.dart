import 'package:bookia_app/core/services/local/app_local_storage.dart';
import 'package:bookia_app/features/auth/data/repo/auth_repo.dart';
import 'package:bookia_app/features/auth/presentation/bloc/auth_event.dart';
import 'package:bookia_app/features/auth/presentation/bloc/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitialState()) {
    on<RegisterEvent>(register);
    on<LoginEvent>(login);
  }

  Future<void> register(RegisterEvent event, Emitter<AuthState> emit) async {
    emit(RegisterLoadingState());

    try {
      await AuthRepo.register(event.params).then((value) {
        if (value != null) {
          AppLocalStorage.cacheData(AppLocalStorage.token, value.data?.token);

          emit(RegisterSuccessState());
        } else {
          emit(AuthErrorState(
              message: 'Unexpected Error occur, please try again'));
        }
      });
    } on Exception {
      emit(AuthErrorState(message: 'Unexpected Error occur, please try again'));
    }
  }

  Future<void> login(LoginEvent event, Emitter<AuthState> emit) async {
    emit(LoginLoadingState());

    try {
      await AuthRepo.login(event.params).then((value) {
        if (value != null) {
          AppLocalStorage.cacheData(AppLocalStorage.token, value.data?.token);
          emit(LoginSuccessState());
        } else {
          emit(AuthErrorState(
              message: 'Unexpected Error occur, please try again'));
        }
      });
    } on Exception {
      emit(AuthErrorState(message: 'Unexpected Error occur, please try again'));
    }
  }
}
