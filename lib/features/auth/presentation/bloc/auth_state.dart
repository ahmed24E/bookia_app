class AuthState {}

class AuthInitialState extends AuthState {}

// login
class LoginLoadingState extends AuthState {}

class LoginSuccessState extends AuthState {}

// register
class RegisterLoadingState extends AuthState {}

class RegisterSuccessState extends AuthState {}

class AuthErrorState extends AuthState {
  String message;
  AuthErrorState({required this.message});
}
