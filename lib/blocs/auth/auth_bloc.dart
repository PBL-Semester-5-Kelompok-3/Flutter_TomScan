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

  // Handle SignUp Event
  Stream<AuthState> _mapSignUpToState(AuthSignUpEvent event) async* {
    yield AuthLoading(); // Show loading state while signing up
    try {
      final user = await userService.signUp(event.email, event.password);
      yield AuthAuthenticated(
          user: user); // Emit AuthAuthenticated state on success
    } catch (e) {
      yield AuthFailure(error: e.toString()); // Emit failure state on error
    }
  }

  // Handle SignIn Event
  Stream<AuthState> _mapSignInToState(AuthSignInEvent event) async* {
    yield AuthLoading(); // Show loading state while signing in
    try {
      final user = await userService.signIn(event.email, event.password);
      yield AuthAuthenticated(
          user: user); // Emit AuthAuthenticated state on success
    } catch (e) {
      yield AuthFailure(error: e.toString()); // Emit failure state on error
    }
  }

  // Handle SignOut Event
  Stream<AuthState> _mapSignOutToState() async* {
    yield AuthLoading(); // Show loading state while signing out
    try {
      await userService.signOut(); // Perform sign-out
      yield AuthUnauthenticated(); // Emit AuthUnauthenticated state after sign-out
    } catch (e) {
      yield AuthFailure(error: e.toString()); // Emit failure state on error
    }
  }
}
