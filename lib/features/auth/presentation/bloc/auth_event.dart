import 'package:bookia_app/features/auth/data/model/request/user_model_params.dart';

class AuthEvent {}

class RegisterEvent extends AuthEvent {
  final UserModelParams params;
  RegisterEvent(this.params);
}

class LoginEvent extends AuthEvent {
  final UserModelParams params;
  LoginEvent(this.params);
}
