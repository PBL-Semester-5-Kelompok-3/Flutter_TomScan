import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toma_scan/blocs/forgot/bloc/forgot_event.dart';
import 'package:toma_scan/services/user_service.dart';
import 'auth_event.dart';
import 'auth_state.dart';
import 'package:toma_scan/blocs/forgot/bloc/forgot_bloc.dart'; // Import ForgotPasswordBloc

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserService userService;
  final ForgotPasswordBloc
      forgotPasswordBloc; // Menambahkan ForgotPasswordBloc sebagai dependensi

  AuthBloc({
    required this.userService,
    required this.forgotPasswordBloc, // Menyuntikkan ForgotPasswordBloc
  }) : super(AuthInitial());

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is AuthSignUpEvent) {
      yield* _mapSignUpToState(event);
    } else if (event is AuthSignInEvent) {
      yield* _mapSignInToState(event);
    } else if (event is AuthSignOutEvent) {
      yield* _mapSignOutToState();
    } else if (event is SendOtpEvent) {
      yield* _mapSendOtpToState(event as SendOtpEvent);
    } else if (event is AuthForgotPasswordEvent) {
      yield* _mapForgotPasswordToState(
          event); // Menangani forgot password di sini
    }
  }

  // Handle SendOtp Event
  Stream<AuthState> _mapSendOtpToState(SendOtpEvent event) async* {
    yield AuthLoading(); // Show loading state while sending OTP
    try {
      await userService
          .sendOtpToEmail(event.email); // Call sendOtp from UserService
      yield AuthOtpSent(); // Emit AuthOtpSent state on success
    } catch (e) {
      yield AuthFailure(
          error:
              'Failed to send OTP: ${e.toString()}'); // Emit failure state on error
    }
  }

  // Handle ForgotPassword Event
  Stream<AuthState> _mapForgotPasswordToState(
      AuthForgotPasswordEvent event) async* {
    yield AuthLoading(); // Show loading state while sending OTP
    try {
      forgotPasswordBloc.add(
          SendOtpEvent(event.email)); // Kirim event OTP ke ForgotPasswordBloc
      yield AuthForgotPasswordSuccess(); // Status sukses setelah OTP dikirim
    } catch (e) {
      yield AuthFailure(
          error:
              'Forgot Password failed: ${e.toString()}'); // Emit failure state on error
    }
  }

  // Handle SignUp Event
  Stream<AuthState> _mapSignUpToState(AuthSignUpEvent event) async* {
    yield AuthLoading(); // Show loading state while signing up
    try {
      final user = await userService.signUp(event.email, event.password);
      yield AuthAuthenticated(
          user: user); // Emit AuthAuthenticated state on success
    } catch (e) {
      yield AuthFailure(
          error:
              'Sign Up failed: ${e.toString()}'); // Emit failure state on error
    }
  }

  // Handle SignIn Event
  Stream<AuthState> _mapSignInToState(AuthSignInEvent event) async* {
    yield AuthLoading(); // Show loading state while signing in
    try {
      final user = await userService.signIn(event.email, event.password);
      yield AuthAuthenticated(
          user: User); // Emit AuthAuthenticated state on success
    } catch (e) {
      yield AuthFailure(
          error:
              'Sign In failed: ${e.toString()}'); // Emit failure state on error
    }
  }

  // Handle SignOut Event
  Stream<AuthState> _mapSignOutToState() async* {
    yield AuthLoading(); // Show loading state while signing out
    try {
      await userService.signOut(); // Perform sign-out
      yield AuthUnauthenticated(); // Emit AuthUnauthenticated state after sign-out
    } catch (e) {
      yield AuthFailure(
          error:
              'Sign Out failed: ${e.toString()}'); // Emit failure state on error
    }
  }
}
