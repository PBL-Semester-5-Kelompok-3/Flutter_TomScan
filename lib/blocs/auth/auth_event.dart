// auth_event.dart
part of 'auth_bloc.dart';

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
  final String password;
  final String confirmPassword;
  final String otp;
  const AuthResetPassword(
      this.email, this.password, this.confirmPassword, this.otp);

  @override
  List<Object> get props => [email, password, confirmPassword, otp];
}

class AuthVerifyOTP extends AuthEvent {
  final String email;
  final String otp;
  const AuthVerifyOTP(this.email, this.otp);

  @override
  List<Object> get props => [email, otp];
}

class AuthLogout extends AuthEvent {}

class AuthGetProfile extends AuthEvent {}

class AuthEditProfile extends AuthEvent {
  final UserModel updatedUser;
  AuthEditProfile(this.updatedUser);
}

class AuthUpdateUsername extends AuthEvent {
  final String username;

  AuthUpdateUsername(this.username);
}

class AuthUpdatePassword extends AuthEvent {
  final String password;

  AuthUpdatePassword(this.password);
}
