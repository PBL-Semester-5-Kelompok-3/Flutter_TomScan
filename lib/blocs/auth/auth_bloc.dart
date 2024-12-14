// auth_bloc.dart
import 'package:bloc/bloc.dart';
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
          emit(AuthLoading()); // Menampilkan status loading
          final message = await AuthService().resetPassword(
              event.email, event.password, event.confirmPassword, event.otp);
          emit(AuthResetPasswordSuccess(message)); // Menampilkan status sukses
        } catch (e) {
          emit(AuthResetPasswordFailed(
              e.toString(), e.toString())); // Menangani error
        }
      } else if (event is AuthLogout) {
        try {
          emit(AuthLoading());
          print('1');
          await AuthService().logout(); // Panggil metode logout
          print('2');
          emit(AuthInitial()); // Pastikan state ini dikeluarkan
          print('3');
        } catch (e) {
          emit(AuthFailed(e.toString())); // Tangani error
        }
      } else if (event is AuthGetProfile) {
        try {
          emit(AuthLoading());
          final user = await AuthService().getProfile(); // Ambil profil
          emit(AuthProfileSuccess(user)); // Emit data profil berhasil
        } catch (e) {
          emit(AuthProfileFailed(e.toString())); // Emit error jika gagal
        }
      } else if (event is AuthEditProfile) {
        try {
          emit(AuthLoading());
          final updatedUser =
              await AuthService().editProfile(event.updatedUser);
          emit(AuthEditProfileSuccess(updatedUser));
        } catch (e) {
          emit(AuthEditProfileFailed(e.toString()));
        }
      }
    });
  }
}
