part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {
  const AuthEvent();

  List<Object> get props => [];
}

class AuthRegister extends AuthEvent {
  final SignUpFormModel data;
  const AuthRegister(this.data);

  @override
  List<Object> get props => [data];
}

class AuthLogin extends AuthEvent {
  final SignInFormModel data;
  const AuthLogin(this.data);

  @override
  List<Object> get props => [data];
}

class AuthForgotPassword extends AuthEvent {
  final String email;
  const AuthForgotPassword(this.email);

  @override
  List<Object> get props => [email];
}

class AuthResetPassword extends AuthEvent {
  final String email;
  const AuthResetPassword(this.email);

  @override
  List<Object> get props => [email];
}

class AuthVerifyOTP extends AuthEvent {
  final String email;
  final String otp;
  const AuthVerifyOTP(this.email, this.otp);

  @override
  List<Object> get props => [email, otp];
}
