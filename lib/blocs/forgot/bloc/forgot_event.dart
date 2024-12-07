// lib/blocs/forgot_password_event.dart

abstract class ForgotPasswordEvent {}

class SendOtpEvent extends ForgotPasswordEvent {
  final String email;

  SendOtpEvent(this.email);
}
