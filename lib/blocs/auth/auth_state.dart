// auth_state.dart
part of 'auth_bloc.dart';

sealed class AuthState {
  const AuthState();

  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthFailed extends AuthState {
  final String e;
  const AuthFailed(this.e);

  @override
  List<Object> get props => [e];
}

class AuthSuccess extends AuthState {
  final UserModel user;
  const AuthSuccess(this.user);

  @override
  List<Object> get props => [user];
}

class AuthForgotPasswordSuccess extends AuthState {
  final String message;
  const AuthForgotPasswordSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class AuthForgotPasswordFailed extends AuthState {
  final String message;
  const AuthForgotPasswordFailed(this.message);

  @override
  List<Object> get props => [message];
}

class AuthResetPasswordSuccess extends AuthState {
  final String message;
  const AuthResetPasswordSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class AuthResetPasswordFailed extends AuthState {
  final String error;
  final String message;
  const AuthResetPasswordFailed(this.error, this.message);

  @override
  List<Object> get props => [error];
}

class AuthVerifyOTPSuccess extends AuthState {
  final String message;
  const AuthVerifyOTPSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class AuthVerifyOTPFailed extends AuthState {
  final String message;
  const AuthVerifyOTPFailed(this.message);

  @override
  List<Object> get props => [message];
}

class AuthLogoutFailed extends AuthState {
  final String message;
  AuthLogoutFailed(this.message);

  @override
  List<Object> get props => [message];
}

class AuthLogoutSuccess extends AuthState {}

// State untuk profil
class AuthProfileSuccess extends AuthState {
  final UserModel user;
  AuthProfileSuccess(this.user);
}

class AuthProfileFailed extends AuthState {
  final String error;
  AuthProfileFailed(this.error);
}

class AuthEditProfileSuccess extends AuthState {
  final UserModel updatedUser;
  AuthEditProfileSuccess(this.updatedUser);
}

class AuthEditProfileFailed extends AuthState {
  final String error;
  AuthEditProfileFailed(this.error);
}
