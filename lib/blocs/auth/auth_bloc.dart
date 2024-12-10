// auth_bloc.dart
import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:toma_scan/models/sign_in_form_model.dart';
import 'package:toma_scan/models/sign_up_form_model.dart';
import 'package:toma_scan/models/user_model.dart';
import 'package:toma_scan/services/auth_service.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthEvent>((event, emit) async {
      if (event is AuthRegister) {
        try {
          emit(AuthLoading());
          final user = await AuthService().register(event.data);
          emit(AuthSuccess(user));
        } catch (e) {
          emit(AuthFailed(e.toString()));
        }
      } else if (event is AuthLogin) {
        try {
          emit(AuthLoading());
          final user = await AuthService().login(event.data);
          emit(AuthSuccess(user));
        } catch (e) {
          emit(AuthFailed(e.toString()));
        }
      } else if (event is AuthForgotPassword) {
        try {
          emit(AuthLoading());
          final message = await AuthService().forgotPassword(event.email);
          emit(AuthForgotPasswordSuccess(message));
        } catch (e) {
          emit(AuthForgotPasswordFailed(e.toString()));
        }
      } else if (event is AuthVerifyOTP) {
        try {
          emit(AuthLoading());
          final message = await AuthService().verifyOTP(event.email, event.otp);
          emit(AuthVerifyOTPSuccess(message));
        } catch (e) {
          emit(AuthVerifyOTPFailed(e.toString()));
        }
      } else if (event is AuthResetPassword) {
        try {
          emit(AuthLoading());
          // Mengirim email yang sesuai untuk reset password
          final message =
              await AuthService().resetPassword(event.email, event.password);
          emit(AuthResetPasswordSuccess(message));
        } catch (e) {
          emit(AuthResetPasswordFailed(e.toString(), "Failed to reset password"));
        }
      }
 else if (event is AuthLogout) {
        try {
          emit(AuthLoading());
          await AuthService().logout(); // Panggil metode logout
          emit(AuthLogoutSuccess()); // Pastikan state ini dikeluarkan
        } catch (e) {
          emit(AuthLogoutFailed(e.toString())); // Tangani error
        }
      }
    });
  }
}
