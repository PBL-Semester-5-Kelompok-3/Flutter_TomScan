import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:toma_scan/blocs/forgot/bloc/forgot_event.dart';
import 'package:toma_scan/blocs/forgot/bloc/forgot_state.dart';
import 'package:toma_scan/services/user_service.dart';

// --- ForgotPasswordBloc ---
class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  final UserService _userService;
  final OtpBloc otpBloc; // Menambahkan OtpBloc sebagai dependensi

  ForgotPasswordBloc(this._userService, this.otpBloc)
      : super(ForgotPasswordInitial());

  @override
  Stream<ForgotPasswordState> mapEventToState(
      ForgotPasswordEvent event) async* {
    if (event is SendOtpEvent) {
      yield ForgotPasswordLoading();

      try {
        final success = await _userService.sendOtpToEmail(event.email);
        if (success) {
          yield ForgotPasswordSuccess();
          // Mengirim event untuk memulai OTP timer
          otpBloc.add(OtpResendEvent());
        } else {
          yield ForgotPasswordFailure('Failed to send OTP');
        }
      } catch (e) {
        yield ForgotPasswordFailure(e.toString());
      }
    }
  }
}

// --- OtpBloc ---
abstract class OtpEvent {}

class OtpResendEvent extends OtpEvent {}

abstract class OtpState {}

class OtpInitialState extends OtpState {}

class OtpSuccessState extends OtpState {}

class OtpFailureState extends OtpState {
  final String error;
  OtpFailureState(this.error);
}

class OtpResendState extends OtpState {
  final int remainingTime;
  OtpResendState(this.remainingTime);
}

class OtpBloc extends Bloc<OtpEvent, OtpState> {
  int _remainingTime = 56;
  Timer? _timer;

  OtpBloc() : super(OtpInitialState());

  @override
  Stream<OtpState> mapEventToState(OtpEvent event) async* {
    if (event is OtpResendEvent) {
      if (_remainingTime == 0) {
        yield* _sendOtp();
      }
    }
  }

  Stream<OtpState> _sendOtp() async* {
    yield OtpResendState(_remainingTime);
    // Simulate OTP send delay and success response
    await Future.delayed(Duration(seconds: 2));
    _startTimer();
    yield OtpSuccessState();
  }

  void _startTimer() {
    _timer?.cancel();
    _remainingTime = 56;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_remainingTime > 0) {
        _remainingTime--;
        add(OtpResendEvent());
      } else {
        _timer?.cancel();
      }
    });
  }

  void dispose() {
    _timer?.cancel();
    super.close();
  }
}
