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
<<<<<<< Updated upstream
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
=======
    // Handle register
    on<AuthRegister>((event, emit) async {
      try {
        emit(AuthLoading());
        final user = await AuthService().register(event.data);
        emit(AuthSuccess(user));
      } catch (e) {
        emit(AuthFailed(e.toString()));
      }
    });

    // Handle forgot password
    on<AuthForgotPassword>((event, emit) async {
      try {
        emit(AuthLoading());
        final result = await AuthService().forgotPassword(event.email);
        emit(AuthForgotPasswordSuccess(result));
      } catch (e) {
        emit(AuthForgotPasswordFailed(e.toString()));
>>>>>>> Stashed changes
      }
    });
  }
}