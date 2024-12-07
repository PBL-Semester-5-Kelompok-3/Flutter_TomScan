import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toma_scan/services/user_service.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserService userService;

  AuthBloc({required this.userService}) : super(AuthInitial());

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is AuthSignUpEvent) {
      yield* _mapSignUpToState(event);
    } else if (event is AuthSignInEvent) {
      yield* _mapSignInToState(event);
    } else if (event is AuthSignOutEvent) {
      yield* _mapSignOutToState();
    }
  }

  Stream<AuthState> _mapSignUpToState(AuthSignUpEvent event) async* {
    yield AuthLoading();
    try {
      final user = await userService.signUp(event.email, event.password);
      yield AuthAuthenticated(user: user);
    } catch (e) {
      yield AuthFailure(error: e.toString());
    }
  }

  Stream<AuthState> _mapSignInToState(AuthSignInEvent event) async* {
    yield AuthLoading();
    try {
      final user = await userService.signIn(event.email, event.password);
      yield AuthAuthenticated(user: user);
    } catch (e) {
      yield AuthFailure(error: e.toString());
    }
  }

  Stream<AuthState> _mapSignOutToState() async* {
    yield AuthLoading();
    try {
      await userService.signOut();
      yield AuthUnauthenticated();
    } catch (e) {
      yield AuthFailure(error: e.toString());
    }
  }
}
