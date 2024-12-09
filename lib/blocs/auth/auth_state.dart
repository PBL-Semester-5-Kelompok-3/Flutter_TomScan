part of 'auth_bloc.dart';

@immutable
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
