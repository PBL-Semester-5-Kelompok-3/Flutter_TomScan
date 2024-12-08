abstract class AuthEvent {}

class AuthSignUpEvent extends AuthEvent {
  final String email;
  final String password;

  AuthSignUpEvent({required this.email, required this.password});
}

class AuthSignInEvent extends AuthEvent {
  final String email;
  final String password;

  AuthSignInEvent({required this.email, required this.password});
}

class AuthForgotPasswordEvent extends AuthEvent {
  final String email;
  AuthForgotPasswordEvent(this.email);
}

class AuthSignOutEvent extends AuthEvent {}
